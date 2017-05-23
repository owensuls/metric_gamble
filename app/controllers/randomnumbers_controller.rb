require 'prometheus/client'

class RandomnumbersController < ApplicationController
    @@result = Prometheus::Client::Gauge.new(:demo_gamble_result, 'Result of playing Metric Gamble app.')
    @@users_inthissession = Prometheus::Client::Counter.new(:demo_gamble_users_inthisession, 'Count of users in this session.')

  def index
    @randomnumbers = Randomnumber.order('number DESC').limit(5)
    @counter = 0
  end

  def show
    @randomnumber = Randomnumber.find(params[:id])
  end

  def create
    @randomnumber = Randomnumber.new(randomnumber_params)

    prometheus = Prometheus::Client.registry

    begin
      prometheus.register(@@result)
      prometheus.register(@@users_inthissession)
    rescue Prometheus::Client::Registry::AlreadyRegisteredError => e
    end

    name = params[:randomnumber][:name]

    if name.nil? || name.empty?
      name = 'Anonymous'
    end

    @@result.set({name: name}, params[:randomnumber][:number].to_i)
    @@users_inthissession.increment

    @randomnumber.save
    redirect_to @randomnumber
  end

  private
  def randomnumber_params
    params.require(:randomnumber).permit(:name, :number)
  end
end
