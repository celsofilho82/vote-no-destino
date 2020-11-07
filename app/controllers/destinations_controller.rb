class DestinationsController < ApplicationController
  before_action :load_destinations, only: [:primeiro_destino, :segundo_destino]

  def home
  end

  def primeiro_destino
    @first_choices = @destinations.first(2)
  end
  
  def segundo_destino
    @second_choices = @destinations.last(3)
  end

  def user
    @user = User.new
  end

  def up_vote
    destino = Destination.find(destination_params[:id])
    voter = Votersession.first_or_create(session_id: request.session_options[:id])
    destino.upvote_by voter
    if request.headers["referer"].include?("primeiro_destino")
      
      redirect_to segundo_destino_path
    elsif request.headers["referer"].include?("segundo_destino")

      redirect_to user_path
    else
      
      render :home
    end
  end

  def create_user
    @user = User.first_or_create(params)
    voter = Votersession.find_by(session_id: request.session_options[:id].to_s)
    voter.update(user_id: user.id)

    render :home
  end

  private

  def load_destinations
    @destinations = Destination.all
  end

  def destination_params
    params.require(:destination).permit(:id)
  end

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
