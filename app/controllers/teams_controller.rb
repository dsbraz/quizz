class TeamsController < ApplicationController
  include AuthorizationRequired

  before_action :require_authorization, only: [:edit, :update]

  authorize_roles [:TEAM]

  # GET /team/new
  def new
    @team = Team.new
    @team.players.build
  end

  # GET /teams/1/edit
  def edit
    @team = Team.find(params[:id])
    @team.players.build
  end

  # POST /teams
  def create
    @team = Team.new(team_params)
    if @team.save
      redirect_to teams_path, notice: "criado com sucesso, agora faca login"
    else
      render :new
    end
  end

  # PUT /teams/1
  def update
    @team = Team.find(params[:id])
    if @team.update(team_params)
      redirect_to edit_team_path(@team), notice: "alterado com sucesso"
    else
      render :edit
    end
  end

  private

  def team_params
    params.require(:team).permit(:username, :password, :password_confirmation,
      players_attributes: [:id, :username, :password, :password_confirmation, :_destroy])
  end
end
