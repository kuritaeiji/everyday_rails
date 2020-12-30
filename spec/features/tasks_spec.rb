require 'rails_helper'

RSpec.feature "Tasks", type: :feature, js: true do
  let(:user) { create(:user) }
  let(:project) { create(:project, owner: user, name: 'test project') }
  let!(:task) { project.tasks.create!(name: 'test task') }

  scenario('ユーザーがタスクの状態を切り替える') do
    user = create(:user)
    project = create(:project, owner: user, name: 'test project')
    task = project.tasks.create(name: 'test task')

    log_in(user)

    go_to_project('test project')

    complete_task('test task')
    expect_complete_task('test task', task)

    undo_complete_task('test task')
    expect_uncomplete_task('test task', task)
  end

  def go_to_project(name)
    click_on(name)
  end
  
  def complete_task(name)
    check(name)
  end
  
  def undo_complete_task(name)
    uncheck(name)
  end
  
  def expect_complete_task(name, task)
    aggregate_failures do
      expect(page).to have_css('label.completed', text: name)
      expect(task.reload.completed).to eq(true)
    end
  end
  
  def expect_uncomplete_task(name, task)
    aggregate_failures do
      expect(page).not_to have_css('label.completed', text: name)
      expect(task.reload.completed).to eq(false)
    end
  end
end