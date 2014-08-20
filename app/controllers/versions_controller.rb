class VersionsController < ApplicationController
  before_filter :authorize

  def create
    self.set_html_preference params[:prefer_html]
    @localization = Localization.find(params[:localization_id])

    if @localization.blurb.project_id == 1
      @overrides = @localization.in_other_projects.where('localizations.published_content = ?', @localization.published_content)
      @overrides.each do |localization|
        localization.revise(params[:version]).save!
      end
    end

    @version = @localization.revise(params[:version])
    @version.save!

    if @version.published?
      flash[:success] = 'Content published. ' +
        'It takes up to 5 minutes for new content to appear on the live site.'
    else
      flash[:success] = 'Draft saved.'
    end

    redirect_to new_localization_version_url(@localization)
  end

  def new
    @localization = Localization.find(params[:localization_id])
    @version = @localization.revise
    @project = @localization.project
    @locale = @project.locale(@localization.locale_id)

    @conflicts = @localization.in_other_projects.where('localizations.published_content != ?', @localization.published_content)
  end
end
