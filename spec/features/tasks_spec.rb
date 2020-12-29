require 'rails_helper'

RSpec.feature "Tasks", type: :feature, js: true do
  scenario('ユーザーがタスクの状態を切り替える') do
    user = create(:user)
    project = create(:project, owner: user, name: 'test project')
    task = project.tasks.create(name: 'test task')

    visit(root_path)
    click_on('Sign in')
    fill_in('Email', with: user.email)
    fill_in('Password', with: user.password)
    click_on('Log in')

    click_on('test project')
    check('test task')

    expect(page).to have_css("label#task_#{task.id}.completed")
    expect(task.reload.completed).to eq(true)

    uncheck('test task')
    expect(page).not_to have_css("label#task_#{task.id}.completed")
    expect(task.reload.completed).to eq(false)
  end
end
