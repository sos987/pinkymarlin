require 'tez_tour'
require 'settings'

class HomeController < ActionController::Base	
  include TezTour

  CODES = ['promocode','mymarlin']

  before_filter :check_code, :except => [:new_session, :create_session]

  layout 'application'

  def index
  	@default_params = default_params
  end

  def reserve
    TourMailer.reserve(params).deliver
    respond_to do |format|
      format.html {:back}
      format.json {render :json => {:reserved => true}}
    end
  end


  def new_session
    render :login, :layout => nil
  end

  def create_session
    if CODES.include?(params[:code])
      cookies[:code] = params[:code]
      redirect_to root_path
    else
      render :login, :layout => nil
    end
  end

private 
  def check_code
    unless CODES.include?(cookies[:code])
      redirect_to login_path
    end
  end
end
