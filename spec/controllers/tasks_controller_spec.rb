require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  describe('#show') do
    before do
      @user = create(:user)
      @project = create(:project, owner: @user)
      @task = @project.tasks.create(name: 'test task')
      sign_in(@user)
    end

    it('json形式でレスポンスを返す') do
      get(:show, format: :json, params: { project_id: @project.id, id: @task.id })
      expect(response.content_type).to eq('application/json')
    end
  end
end
