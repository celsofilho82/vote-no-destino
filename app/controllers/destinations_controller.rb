class DestinationsController < ApplicationController
  before_action :load_destinations, only: [:primeiro_destino, :segundo_destino]

  def home
  end

  def primeiro_destino
    @first_choices = @destinations.first(2)
  end

  def up_vote
    destiny = Destination.find(destination_params[:id])
    voter = Votersession.first_or_create(session_id: request.session_options[:id])
    destiny.upvote_by voter
    if request.headers["referer"].include?("primeiro_destino")
      
      redirect_to segundo_destino_path
    else
      
      render :home
    end

  end

  def segundo_destino
    @second_choices = @destinations.last(3)
  end

  private

  def load_destinations
    @destinations = Destination.all
  end

  def destination_params
    params.require(:destination).permit(:id)
  end
end
