class Team < ActiveRecord::Base
  include User
  has_many :players
  accepts_nested_attributes_for :players, allow_destroy: true, reject_if: ->(a) { a[:username].blank? }
end
