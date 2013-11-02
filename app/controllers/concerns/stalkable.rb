module Stalkable
  extend ActiveSupport::Concern

  included do
    before_action :_stalk_
  end

  def stalk(params)
    Event.create(params)
  end

  private

  def _stalk_
    if respond_to?(:current_user) && !current_user.nil?
      stalk({ player: current_user, controller: params[:controller],
          action: params[:action], session: session.id, opt: params[:id] })
    end
  end
end
