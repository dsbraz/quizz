class Player < ActiveRecord::Base
  include User
  belongs_to :team
  has_many :answers
  has_many :events
end
