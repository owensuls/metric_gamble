require 'prometheus/client'

class RandomnumbersController < ApplicationController
  def index
    @randomnumbers = Randomnumber.order('number DESC').limit(10)
  end

  def show
    @randomnumber = Randomnumber.find(params[:id])
  end

  def new
  end

  def create
    @randomnumber = Randomnumber.new(randomnumber_params)

    if @requests.nil?
      prometheus = Prometheus::Client.registry
      @requests = prometheus.gauge(:demo_metric_gamble_result, 'Random number selected for this users turn.')
    else
      #
    end

    @requests.set({name: "Owen"}, rand(10000))

    @randomnumber.save
    redirect_to @randomnumber
  end

  private
  def randomnumber_params
    params.require(:randomnumber).permit(:name, :number)
  end
end
