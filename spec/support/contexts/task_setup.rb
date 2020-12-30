RSpec.shared_context('task setup') do
  let(:user) { create(:user) }
  let(:project) { create(:project, owner: user) }
  let(:task) { project.tasks.create(name: 'test task') }
end