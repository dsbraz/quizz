class PlayersController < ApplicationController
  include AuthorizationRequired, Stalkable

  authorize_roles [:PLAYER]

  # GET /players/1
  def show
    @player = Player.find(params[:id])
  end

  # GET /players/1/edit
  def edit
    @player = Player.find(params[:id])
  end

  # PATCH /players/1
  def update
    @player = Player.find(params[:id])
    if @player.update(player_params)
      cache_write_user
      redirect_to tracks_path
    else
      render :edit
    end
  end

  private

  def cache_write_user
    Rails.cache.write("/users/#{@player.username}", @player, expires_in: 20.minutes)
  end

  def player_params
    params.require(:player).permit(:avatar)
  end
end
