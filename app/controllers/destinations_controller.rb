class DestinationsController < ApplicationController
  before_action :load_destinations, only: [:primeiro_destino, :segundo_destino, :rank]
  before_action :set_voter, only: [:up_vote]

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
    user = User.new(user_params)

    if User.exists?(user_params)
      user = User.find_by(user_params)
      confirm_vote(user)

      return redirect_to rank_path user
    end

    if user.save
      confirm_vote(user)
      
      return redirect_to rank_path user
    else
      flash[:error] = user.errors
      return redirect_to user_path
    end
  end

  def rank
    voted_items = []
    sessions = Votersession.where(user_id: params[:id])
    sessions.each do |session|
      voted_items << session.find_voted_items
    end

    @destinos = voted_items
                .flatten
                .group_by{ |i| i }
                .map{ |k,v| [k.name, v.count] }.to_h
  end

  private

  def confirm_vote(user)
    Votersession.last(2).each{ |session| session.update(user_id: user.id) }
  end

  def set_voter
    @voter = Votersession.create!(
      session_id: request.session_options[:id].to_s
    )
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
