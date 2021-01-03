require 'rails_helper'

RSpec.describe GeocodeUserJob, type: :job do
  it('ユーザーのジオコードを返す') do
    user_double = instance_double(User, geocode: 'geocode')
    GeocodeUserJob.perform_now(user_double)
    expect(user_double).to have_received(:geocode)
  end
end
