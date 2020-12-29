require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe('#index') do
    it('responds successfully') do
      get(:index)
      expect(response.status).to eq(200)
    end
  end
end