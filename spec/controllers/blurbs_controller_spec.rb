require 'spec_helper'

describe BlurbsController do
  describe '#create' do
    let(:project) { create(:project) }
    it 'creates a blurb' do
      expect {
        post :create, {
          project_id: project,
          locale_id: project.locales.first.id,
          key: 'a.new.key'
        }
      }.to change { Blurb.count }.by(1)
    end

    it 'redirect_to the new localization' do
      post :create, {
        project_id: project,
        key: 'a.new.key',
        locale_id: project.locales.first.id
      }
      localization = Blurb.find_by_key('a.new.key').localizations.in_locale(project.locales.first).first
      response.should redirect_to new_localization_version_path(localization_id: localization)
    end

  end
end
