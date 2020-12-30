require 'rails_helper'

RSpec.describe "Projects Api", type: :request do
  it('一件のプロジェクトを読み出すこと') do
    user = create(:user)
    create(:project, name: "other user's project")
    project = create(:project, owner: user, name: "user's project")

    get(api_projects_path, params: { user_email: user.email, user_token: user.authentication_token })

    expect(response.status).to eq(200)
    json = JSON.parse(response.body)
    expect(json[0]['name']).to eq("user's project")
    expect(json.length).to eq(1)
    project_id = json[0]['id']

    get(api_project_path(project_id), params: { user_email: user.email, user_token: user.authentication_token })
    expect(response.status).to eq(200)
    json = JSON.parse(response.body)
    expect(json['name']).to eq("user's project")
  end

  it('プロジェクトを作成できること') do
    user = create(:user)
    project_param = attributes_for(:project)

    expect {
      post(api_projects_path, params: {
        user_email: user.email,
        user_token: user.authentication_token,
        project: project_param
        })
      }.to change(user.projects, :count).by(1)

    expect(response.status).to eq(200)
  end
end
