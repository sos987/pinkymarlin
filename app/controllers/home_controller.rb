require 'tez_tour'
require 'settings'

class HomeController < ActionController::Base	
  include TezTour

  CODES = ['promocode','mymarlin']

  before_filter :check_code, :except => [:new_session, :create_session]

  layout 'application'

  def index
  	@default_params = default_params
  	@accommodations = accommodations
  end

  def search
  	@default_params = default_params
  	@accommodations = accommodations
    @city = City.find(params[:cityId])
    @country = Country.find(params[:countryId])
    @count = params[:adult].to_i + params[:child].to_i
  end

  def reserve
    TourMailer.reserve(params).deliver
    respond_to do |format|
      format.html {:back}
      format.json {render :json => {:reserved => true}}
    end
  end


  def new_session
    render :login
  end

  def create_session
    if CODES.include?(params[:code])
      cookies[:code] = params[:code]
      redirect_to root_path
    else
      render :login
    end
  end

private 
  def check_code
    unless CODES.include?(cookies[:code])
      redirect_to login_path
    end
  end
end
