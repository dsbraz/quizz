module User
  extend ActiveSupport::Concern

  included do
    has_secure_password
    validates :username, presence: true, uniqueness: true
  end

  def role
    self.class.name.upcase.to_sym
  end

  def has_roles?(roles)
    roles.empty? || roles.include?(role)
  end

  def self.find_by(filter)
    Player.find_by(filter) || Team.find_by(filter)
  end
end
