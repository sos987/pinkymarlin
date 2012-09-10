class ApplicationController < ActionController::Base
  protect_from_forgery

  append_view_path 'content/pages'

  if Rails.application.config.action_controller.perform_caching
    before_filter do
      expires_in 10.minutes, :public => true
    end
  end

  def or_deploy_date date
    restart_date = File.new(Rails.root.join('tmp', 'restart.txt')).mtime rescue 1.year.ago
    [restart_date, date].max
  end

  # disable etags if needed
  if !Rails.application.config.cache_etags
    def stale? *args
      true
    end
    def fresh_when *args
    end
  end

  def flash
    {}
  end

  def section_based_template_path
    [params[:section], params[:page]].compact.join('/').downcase
  end
end
