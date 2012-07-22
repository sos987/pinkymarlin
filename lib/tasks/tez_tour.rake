require 'tez_tour'
require 'resque/tasks'

namespace :tez_tour do
  desc "Delete existing genres/subgenres and tracks"
  task :update_references => :environment do
  	TezTour.update_references
  end
end