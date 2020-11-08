class DestinationsController < ApplicationController
  before_action :load_destinations, only: [:primeiro_destino, :segundo_destino, :rank]
  before_action :set_voter, only: [:up_vote, :create_user, :rank]

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
    destino.vote_by voter: @voter, :duplicate => true
    if request.headers["referer"].include?("primeiro_destino")
      
      redirect_to segundo_destino_path
    elsif request.headers["referer"].include?("segundo_destino")

      redirect_to user_path
    else
      
      render :home
    end
  end

  def create_user
    if User.exists?(user_params)
      user = User.find_by(user_params)
      @voter.update(user_id: user.id)

      redirect_to rank_path
    end
    user = User.create!(user_params)
    @voter.update(user_id: user.id)
    
    redirect_to rank_path
  end

  def rank
    voted_items = @voter.find_voted_items
    @destinos = voted_items.group_by{|i| i}.map{|k,v| [k.name, v.count] }.to_h
  end

  private

  def set_voter
    @voter = Votersession.first_or_create(session_id: session_id)
  end

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
