require 'prometheus/client'

class RandomnumbersController < ApplicationController
    @@requests = Prometheus::Client::Counter.new(:demo, 'Counter\'s gotta count, friendo')

  def index
    @randomnumbers = Randomnumber.order('number DESC').limit(8)
    @counter = 0
  end

  def show
    @randomnumber = Randomnumber.find(params[:id])
  end

  def create
    @randomnumber = Randomnumber.new(randomnumber_params)

    prometheus = Prometheus::Client.registry

    begin
      prometheus.register(@@requests)
    rescue Prometheus::Client::Registry::AlreadyRegisteredError => e
    end

    @@requests.increment service: 'Demo'

    @randomnumber.save
    redirect_to @randomnumber
  end

  private
  def randomnumber_params
    params.require(:randomnumber).permit(:name, :number)
  end
end
