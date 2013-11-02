class SessionsController < ApplicationController
  # GET /sessions/new
  def new
  end

  # POST /sessions
  def create
    authenticate do |user|
      redirect_to player_path(user)
    end
  end

  # DELETE /sessions/1
  def destroy
    reset_session
  end

  # GET /sessions/teams/new
  def new_team
    render layout: "teams"
  end

  # POST /sessions/teams
  def create_team
    authenticate do |user|
      redirect_to edit_team_path(user)
    end
  end

  # DELETE /sessions/teams/1
  def destroy_team
    reset_session
  end

  private

  def authenticate
    user = cache_fetch_user
    if user.try :authenticate, params[:password]
      session[:username] = user.username
      yield user
    else
      redirect_to :back, notice: "usuario e/ou senha invalidos"
    end
  end

  def cache_fetch_user
    Rails.cache.fetch("/users/#{params[:username]}", expires_in: 20.minutes) do
      User.find_by username: params[:username]
    end
  end
end
