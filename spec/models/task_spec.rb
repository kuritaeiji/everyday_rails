require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:project) { create(:project) }

  it('プロジェクトと名前があれば有効') do
    task = Task.new(project: project, name: 'task')
    expect(task).to be_valid
  end

  it('プロジェクトが無ければ無効') do
    task = Task.new(name: 'task')
    task.valid?
    expect(task.errors[:project]).to include('must exist')
  end

  it('名前が無ければ無効') do
    task = Task.new(project: project)
    task.valid?
    expect(task.errors[:name]).to include("can't be blank")
  end
end
