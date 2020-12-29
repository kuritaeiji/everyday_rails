require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  describe('#index') do
    context('when user logged in') do
      before do
        @user = create(:user)
        sign_in(@user)
      end
  
      it('responds successfully') do
        get(:index)
        expect(response.status).to eq(200)
      end
    end

    context('when user did not log in') do
      it('returns a 302 response and redirect to sign-in page') do
        get(:index)
        expect(response.status).to eq(302)
        expect(response).to redirect_to('/users/sign_in')
      end
    end
  end

  describe('#show') do
    context('認可されたユーザー') do
      before do
        @user = create(:user)
        @project = create(:project, owner: @user)
        sign_in(@user)
      end

      it('正常にレスポンスを返す') do
        get(:show, params: { id: @project.id })
        expect(response.status).to eq(200)
      end
    end

    context('認可されていないユーザー') do
      before do
        @user = create(:user)
        @project = create(:project, owner: @user)
        @other_user = create(:user)
        sign_in(@other_user)
      end

      it('ダッシュボードにリダイレクトする') do
        get(:show, params: { id: @project.id })
        expect(response).to redirect_to(root_url)
      end
    end
  end

  describe('#create') do
    context('認証済みのユーザー') do
      before do
        @user = create(:user)
        sign_in(@user)
      end

      context('有効な属性値の時') do
        it('プロジェクトを作成する') do
          project_params = attributes_for(:project)
          expect {
            post(:create, params: { project: project_params })
          }.to change(@user.projects, :count).by(1)
        end
      end

      context('不正な属性値の時') do
        it('プロジェクトが作成できない') do
          project_params = attributes_for(:project, :invalid)
          expect { 
            post(:create, params: { project: project_params })
          }.not_to change(@user.projects, :count)
        end
      end
    end

    context('認証されていないユーザー') do
      it('302レスポンスを返す') do
        project_params = attributes_for(:project)
        post(:create, params: { project: project_params })
        expect(response.status).to eq(302)
      end

      it('サインイン画面にリダイレクトする') do
        project_params = attributes_for(:project)
        post(:create, params: { project: project_params })
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe('#update') do
    context('認可されたユーザー') do
      before do
        @user = create(:user)
        sign_in(@user)
        @project = create(:project, owner: @user)
      end

      it('プロジェクトを更新できる') do
        project_params = attributes_for(:project, name: 'new project')
        patch(:update, params: { id: @project.id, project: project_params })
        expect(@project.reload.name).to eq('new project')
      end
    end

    context('認可されていないユーザー') do
      before do
        @user = create(:user)
        @project = create(:project, owner: @user, name: 'same project')
        @other_user = create(:user)
        sign_in(@other_user)
      end

      it('プロジェクトを更新できないこと') do
        project_params = attributes_for(:project)
        patch(:update, params: { id: @project.id, project: project_params })
        expect(@project.reload.name).to eq('same project')
      end

      it('ダッシュボードにリダイレクトする') do
        project_params = attributes_for(:project)
        patch(:update, params: { id: @project.id, project: project_params })
        expect(response).to redirect_to(root_url)
      end
    end

    context('ログインしていないユーザー') do
      before do
        @project = create(:project)
      end

      it('302レスポンスを返す') do
        project_params = attributes_for(:project)
        patch(:update, params: { id: @project.id, project: project_params })
        expect(response.status).to eq(302)
      end

      it('ログイン画面にリダイレクトする') do
        project_params = attributes_for(:project)
        patch(:update, params: { id: @project.id, project: project_params })
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe('#destroy') do
    context('認可されたユーザー') do
      before do
        @user = create(:user)
        @project = create(:project, owner: @user)
        sign_in(@user)
      end

      it('プロジェクトを削除できる') do
        expect {
          delete(:destroy, params: { id: @project.id })
        }.to change(@user.projects, :count).by(-1)
      end
    end

    context('認可されてないユーザー') do
      before do
        @user = create(:user)
        @project = create(:project, owner: @user)
        @other_user = create(:user)
        sign_in(@other_user)
      end

      it('プロジェクを削除できない') do
        expect {
          delete(:destroy, params: { id: @project.id })
        }.not_to change(Project, :count)
      end

      it('ダッシュボードにリダイレクト') do
        delete(:destroy, params: { id: @project.id })
        expect(response).to redirect_to(root_url)
      end
    end

    context('ログインしていないユーザー') do
      before do
        @project = create(:project)
      end

      it('302レスポンスを返す') do
        delete(:destroy, params: { id: @project.id })
        expect(response.status).to eq(302)
      end

      it('ログイン画面にリダイレクトする') do
        delete(:destroy, params: { id: @project.id })
        expect(response).to redirect_to(new_user_session_path)
      end

      it('プロジェクを削除できない') do
        expect {
          delete(:destroy, params: { id: @project.id })
        }.not_to change(Project, :count)
      end
    end
  end
end
