class DestinationsController < ApplicationController
  before_action :load_destinations, only: [:primeiro_destino, :segundo_destino, :rank]

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
    voter = Votersession.first_or_create(session_id: session_id)
    destino.vote_by voter: voter, :duplicate => true
    if request.headers["referer"].include?("primeiro_destino")
      
      redirect_to segundo_destino_path
    elsif request.headers["referer"].include?("segundo_destino")

      redirect_to user_path
    else
      
      render :home
    end
  end

  def create_user
    @user = User.first_or_create(user_params)
    voter = Votersession.find_by(session_id: session_id)
    voter.update(user_id: user.id)

    redirect_to rank_path
  end

  def rank
    voted_items = Votersession.find_by(session_id: session_id).find_voted_items
    @destinos = voted_items.group_by{|i| i}.map{|k,v| [k.name, v.count] }.to_h
  end

  private

  def session_id
    request.session_options[:id].to_s
  end

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
