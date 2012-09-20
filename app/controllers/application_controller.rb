class ApplicationController < ActionController::Base
  protect_from_forgery

  append_view_path 'content/pages'


  def section_based_template_path
    [params[:section], params[:page]].compact.join('/').downcase
  end
end
