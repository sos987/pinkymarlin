#
require 'open-uri'


namespace :tez_tour do
  REFERENCES_URL = 'http://search.teztour.com/toursearch/references?locale=ru&formatResult=true&xml=false'
  desc "Delete existing genres/subgenres and tracks"
  task :update_references => :environment do
  	content = open(REFERENCES_URL).read
  	content = ActiveSupport::JSON.decode(content)
  	content['cities'].each do |c|
  		city = City.find_or_create_by_id(c['cityId'])
  		city.name = c['name']
  		city.save!
  	end
  	content['countries'].each do |c|
  		country = Country.find_or_create_by_id(c['countryId'])
  		country.name = c['name']
  		country.save!
  	end
  	print "Finded #{City.all.length} cities and #{Country.all.length} countries"
  end
end