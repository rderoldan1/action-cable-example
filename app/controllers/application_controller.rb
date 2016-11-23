class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :publish_event

  private

  def publish_event
    ActionCable.server.broadcast('events', message: "User #{rand(100)} visited #{request.path}" )
  end
end
