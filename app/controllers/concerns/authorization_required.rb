module AuthorizationRequired
  extend ActiveSupport::Concern

  included do
    before_action :require_authorization
  end

  module ClassMethods
    def authorize_roles(roles)
      define_method :_authorize_roles_ do
        roles
      end
    end
  end

  def current_user
    @current_user ||= cache_fetch_user
  end

  private

  def require_authorization
    unless authorized?
      render file: Rails.public_path.join("401.html"),
             status: :unauthorized,
             layout: false
    end
  end

  def authorized?
    current_user.try :has_roles?, _authorize_roles_
  end

  def _authorize_roles_
    []
  end

  def cache_fetch_user
    Rails.cache.fetch("/users/#{session[:username]}", expires_in: 20.minutes) do
      User.find_by(username: session[:username]) if session[:username]
    end
  end
end
