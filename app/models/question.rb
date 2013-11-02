require 'json'

class Question < ActiveRecord::Base
  belongs_to :track
  has_many :answers
  validates :name, :answer_key, presence: true
  delegate :name, :resume, to: :track, prefix: true
  delegate :create, to: :answers, prefix: true

  def correct?(json_value)
    JSON.load(answer_key) == JSON.load(json_value)
  end

  def first_answer_correct?
    correct? answers.first.try(:json_value)
  end
end
