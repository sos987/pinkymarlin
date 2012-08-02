# coding: utf-8
require 'open-uri'

module TezTour
	REFERENCES_URL = 'http://search.teztour.com/toursearch/references?locale=ru&formatResult=true&xml=false'

	def self.update_references
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

	def default_params
		{
		  	:currency => 8390,
		  	:noTicketsFrom => false,
		  	:noTicketsTo => false
	    }
	end

	def self.accommodations
		[{
	      "accommodationId" => 1,
	      "name" => "1 Взрослый",
	      "children" => 0,
	      "adult" => 1
	    },
	    {
	      "accommodationId" => 14317,
	      "name" => "1 Взрослый и 1 Ребенок",
	      "children" => 1,
	      "adult" => 1
	    },
	    {
	      "accommodationId" => 14357,
	      "name" => "1 Взрослый и 2 Ребенка",
	      "children" => 2,
	      "adult" => 1
	    },
	    {
	      "accommodationId" => 2,
	      "name" => "2 Взрослых",
	      "children" => 0,
	      "adult" => 2
	    },
	    {
	      "accommodationId" => 14258,
	      "name" => "2 Взрослых и 1 Ребенок",
	      "children" => 1,
	      "adult" => 2
	    },
	    {
	      "accommodationId" => 14356,
	      "name" => "2 Взрослых и 2 Ребенка",
	      "children" => 2,
	      "adult" => 2
	    },
	    {
	      "accommodationId" => 3,
	      "name" => "3 Взрослых",
	      "children" => 0,
	      "adult" => 3
	    },
	    {
	      "accommodationId" => 21347,
	      "name" => "3 Взрослых и 1 Ребенок",
	      "children" => 1,
	      "adult" => 3
	    },
	    {
	      "accommodationId" => 26274,
	      "name" => "3 Взрослых и 2 Детей",
	      "children" => 2,
	      "adult" => 3
	    },
	    {
	      "accommodationId" => 15352,
	      "name" => "4 Взрослых",
	      "children" => 0,
	      "adult" => 4
	    },
	    {
	      "accommodationId" => 26275,
	      "name" => "4 Взрослых и 1 Ребенок",
	      "children" => 1,
	      "adult" => 4
	    },
	    {
	      "accommodationId" => 31212,
	      "name" => "4 Взрослых и 2 Детей",
	      "children" => 2,
	      "adult" => 4
	    },
	    {
	      "accommodationId" => 26273,
	      "name" => "5 Взрослых",
	      "children" => 0,
	      "adult" => 5
	    },
	    {
	      "accommodationId" => 67982,
	      "name" => "5 Взрослых и 1 Ребенок",
	      "children" => 1,
	      "adult" => 5
	    },
	    {
	      "accommodationId" => 15351,
	      "name" => "6 Взрослых",
	      "children" => 0,
	      "adult" => 6
	    }]
	end

	def self.rAndBs 
		[{
	      "rAndBId" => '',
	      "name" => "Все возможные"
	    },
	    {
	      "rAndBId" => 15350,
	      "name" => "Размещение без питания",
	      "weight" => 0
	    },
	    {
	      "rAndBId" => 2424,
	      "name" => "Только завтраки",
	      "weight" => 1
	    },
	    {
	      "rAndBId" => 2474,
	      "name" => "Завтрак и ужин",
	      "weight" => 3
	    },
	    {
	      "rAndBId" => 2749,
	      "name" => "Завтрак, обед и ужин",
	      "weight" => 5
	    },
	    {
	      "rAndBId" => 5737,
	      "name" => "Все включено",
	      "weight" => 7
	    },
	    {
	      "rAndBId" => 5738,
	      "name" => "Ультра все включено",
	      "weight" => 8
	    }]
	end
end