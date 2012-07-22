require 'yaml'
YAML::ENGINE.yamler= 'syck'

require 'settingslogic'

eval %Q{
  class ::Rails
    class << self
      def root
        '#{path}'
      end
      def env
        '#{environment}'
      end
    end
  end
}

require File.expand_path("../../lib/settings.rb", __FILE__)

# Don't use stuff above in good projects unless you know what you're doing

set :output, path + "/log/cron.log"

set :job_template, '/bin/bash -c ":job"'

job_type :rake,    'cd :path && RAILS_ENV=:environment && PATH=/usr/local/bin:$PATH && bundle exec rake :task --silent :output'

every 1.day, :at => '1:00am' do
  rake "tez_tour:update_references"
end