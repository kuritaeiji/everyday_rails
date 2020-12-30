require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  include_context('task setup')

  describe('#show') do
    it('json形式でレスポンスを返す') do
      sign_in(user)
      get(:show, format: :json, params: { project_id: project.id, id: task.id })
      expect(response).to have_content_type('application/json')
    end
  end
end
