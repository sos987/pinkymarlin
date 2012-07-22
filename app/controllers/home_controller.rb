require 'tez_tour'
require 'settings'

class HomeController < ActionController::Base	
  include TezTour

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
end
