class TracksController < ApplicationController
  include AuthorizationRequired, Stalkable

  authorize_roles [:PLAYER]

  # GET /tracks
  def index
    @tracks = cache_fetch_tracks
    @done_statuses = @tracks.map { |track| track.done? current_user }
  end

  # GET /tracks/1/resume
  def resume
    track = cache_fetch_track
    question = track.resume current_user
    redirect_to edit_question_path question
  end

  # GET /tracks/1/summary
  def summary
    @track = cache_fetch_track
    @score = @track.summarize current_user
    @avatar = current_user.avatar
  end

  private

  def cache_fetch_tracks
    Rails.cache.fetch("/tracks", expires_in: 24.hours) do
      Track.all.load
    end
  end

  def cache_fetch_track
    Rails.cache.fetch("/tracks/#{params[:id]}", expires_in: 24.hours) do
      Track.find(params[:id])
    end
  end
end
