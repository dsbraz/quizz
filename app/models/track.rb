class Track < ActiveRecord::Base
  has_many :questions
  validates :name, presence: true

  def resume(player)
    unanswered_questions(player).first
  end

  def summarize(player)
    questions.reduce(0) do |acc, question|
      question.first_answer_correct? ? acc += 1 : acc
    end
  end

  def done?(player)
    resume(player).nil?
  end

  private

  def answered_questions(player)
    questions.joins(:answers).where(answers: { player_id: player.id }).distinct
  end

  def unanswered_questions(player)
    questions.where.not(id: answered_questions(player))
  end
end
