class WelcomeController < ApplicationController
  def index
    redirect_to :controller => 'randomnumbers', :action => 'index'

  end
end
