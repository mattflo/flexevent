class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :handle_cookies
  before_filter :secure, :only => [:new, :create, :edit, :destroy]
  def handle_cookies
    cookies.permanent[:_flexevent_admin_key] = "set me" if cookies[:_flexevent_admin_key].nil?
  end
  def secure
  	# puts cookies[:_flexevent_admin_key] 
  	render :nothing => true, :status => 403 unless cookies[:_flexevent_admin_key] == ENV['FLEX_EVENT_ADMIN_KEY']
  end
end
