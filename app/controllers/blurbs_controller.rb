class BlurbsController < ApplicationController
  before_filter :authorize

  def destroy
    blurb = Blurb.find(params[:id])
    blurb.destroy
    flash[:notice] = 'Blurb successfully deleted'
    redirect_to blurb.project
  end

  def create
    project = find_by_project_id
    locale = Locale.find_by_id(params[:locale_id])
    project.create_defaults({ "#{locale.key}.#{params[:key]}"=> '' })
    localization = Blurb.find_by_key(params[:key])
                        .localizations
                        .in_locale(locale)
                        .first
    redirect_to new_localization_version_path(localization_id: localization)
  end
end
