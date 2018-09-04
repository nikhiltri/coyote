class ScavengerHunt::PlayersController < ScavengerHunt::ApplicationController

  before_action :find_player

  def create
    if @player.update_attributes(player_attributes)
      redirect_to player_path
    else
      render :new
    end
  end

  def new
  end

  def show
    redirect_to new_player_path unless current_player? && current_player.email.present?
  end

  def update
    if @player.update_attributes(player_attributes)
      redirect_to player_path
    else
      render :new
    end
  end

  private

  def find_player
    @player = current_player || ScavengerHunt::Player.new
  end

  def player_attributes
    params[:player].permit(:email, :name)
  end
end
