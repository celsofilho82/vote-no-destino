class DestinationsController < ApplicationController
  def home
  end

  def index
    @destinations = Destination.all
  end
end
