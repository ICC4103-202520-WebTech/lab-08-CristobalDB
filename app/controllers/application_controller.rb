class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  rescue_from CanCan::AccessDenied do |e|
    redirect_to recipes_path, alert: e.message.presence || "No tienes permisos para realizar esa acción."
  end
end
