require 'csv'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_family

  private

  def require_code
    if cookies[:code].nil? || current_family.nil?
      redirect_to :home
    end
  end

  def current_family
    RequestStore.store[:current_family] ||= Family.find_by_code cookies[:code]
  end

end
