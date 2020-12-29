require 'rails_helper'

RSpec.feature "Projects", type: :feature do
  scenario('ユーザーがプロジェクトを作成する') do
    user = create(:user)

    visit(root_path)
    click_on('Sign in')
    fill_in('Email', with: user.email)
    fill_in('Password', with: user.password)
    click_on('Log in')

    expect {
      click_on('New Project')
      fill_in('Name', with: 'project')
      fill_in('Description', with: 'description')
      click_on('Create Project')

      expect(page).to have_content('Project was successfully created.')
      expect(page).to have_content('Project')
      expect(page).to have_content('description')
      expect(page).to have_content("Owner: #{user.name}")

    }.to change(user.projects, :count).by(1)
  end
end
