class QuestionsController < ApplicationController
  include AuthorizationRequired, Stalkable

  authorize_roles [:PLAYER]

  # GET /questions/1/edit
  def edit
    @question = cache_fetch_question
    @avatar = current_user.avatar
    render question_template_path
  end

  # PATCH /questions/1
  def update
    @question = cache_fetch_question
    if @question.answers_create(answer_params) && correctly_answered?
      next_question = @question.track_resume(current_user)
      if next_question.nil?
        redirect_to summary_track_path(@question.track)
      else
        redirect_to edit_question_path(next_question)
      end
    else
      @avatar = current_user.avatar
      render question_template_path
    end
  end

  private

  def cache_fetch_question
    Rails.cache.fetch("/questions/#{params[:id]}", expires_in: 24.hours) do
      Question.includes(:track).find(params[:id])
    end
  end

  def answer_params
    params.require(:question).require(:answer).permit(:json_value, :player_id).tap do |whitelist|
      whitelist[:player_id] = current_user.id
    end
  end

  def correctly_answered?
    @question.correct? params[:question][:answer][:json_value]
  end

  def question_template_path
    "questions/#{@question.track_name}/#{@question.name}"
  end
end
