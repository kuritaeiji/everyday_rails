require 'rails_helper'

RSpec.feature "Projects", type: :feature do
  scenario('ユーザーがプロジェクトを作成する') do
    user = create(:user)

    log_in(user)

    expect {
      click_on('New Project')
      fill_in('Name', with: 'project')
      fill_in('Description', with: 'description')
      click_on('Create Project')

    }.to change(user.projects, :count).by(1)

    aggregate_failures do
      expect(page).to have_content('Project was successfully created.')
      expect(page).to have_content('Project')
      expect(page).to have_content('description')
      expect(page).to have_content("Owner: #{user.name}")
    end
  end
end
