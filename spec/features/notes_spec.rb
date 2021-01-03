require 'rails_helper'

RSpec.feature "Notes", type: :feature do
  let(:user) { create(:user) }
  let!(:project) { create(:project, owner: user, name: 'test project') }

  scenario('ファイルをアップロードする') do
    log_in(user)

    click_on('test project')
    click_on('Add Note')

    fill_in('Message', with: 'message')
    attach_file('Attachment', Rails.root.join('spec/files/a.jpg').to_s)
    click_on('Create Note')

    save_and_open_page

    expect(page).to have_content('message')
    expect(page).to have_content('Note was successfully created.')
    expect(page).to have_content('a.jpg (image/jpeg')
  end
end
