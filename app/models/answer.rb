class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :player
  validates :json_value, presence: true
end
