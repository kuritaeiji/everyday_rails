require 'rails_helper'

RSpec.describe "Homes", type: :request do
  it('正常なレスポンスを返す') do
    get(root_path)
    expect(response.status).to eq(200)
  end
end
