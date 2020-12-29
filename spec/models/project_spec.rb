require 'rails_helper'

RSpec.describe Project, type: :model do
  it('does not allow duplicate project names per user') do
    user = User.create(
      email: 'fff@yahoo.co.jp',
      password: 'password',
      first_name: 'eiji',
      last_name: 'kurita'
    )

    project = user.projects.create(name: 'project')
    new_project = user.projects.new(name: 'project')

    new_project.valid?
    expect(new_project.errors[:name][0]).to eq('has already been taken')
  end

  it('allowes two users to share a project name') do
    user = User.create(
      email: 'fff@yahoo.co.jp',
      password: 'password',
      first_name: 'eiji',
      last_name: 'kurita'
    )

    project = user.projects.create(name: 'project')

    other_user = User.create(
      email: 'ffff@yahoo.co.jp',
      password: 'password',
      first_name: 'eiji',
      last_name: 'kurita'
    )

    other_project = other_user.projects.new(name: 'project')
    expect(other_project).to be_valid
  end

  describe('late? method') do
    it('is late when he due date is past today') do
      project = build(:project, :due_yesterday)
      expect(project.late?).to eq(true)
    end

    it('is on time when due date is today') do
      project = build(:project, :due_today)
      expect(project.late?).to eq(false)
    end

    it('is on time when due date is tomorrow') do
      project = build(:project, :due_tomorrow)
      expect(project.late?).to eq(false)
    end
  end

  it('can have 5 notes') do
    project = create(:project, :with_notes)
    expect(project.notes.length).to eq(5)
  end
end
