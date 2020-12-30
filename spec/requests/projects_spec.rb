require 'rails_helper'

RSpec.describe "Projects", type: :request do
  describe('POST /projects') do
    context('認証済みのユーザーの時') do
      before do
        @user = create(:user)
        sign_in(@user)
      end

      it('プロジェクトを追加できる') do
        project_param = attributes_for(:project)
        expect {
          post(projects_path, params: { project: project_param })
        }.to change(@user.projects, :count).by(1)
      end
    end

    context('認証されていないユーザーのとき') do
      it('プロジェクトを作成できない') do
        project_param = attributes_for(:project)
        expect {
          post(projects_path, params: { project: project_param })
        }.not_to change(Project, :count)
      end
    end
  end
end
