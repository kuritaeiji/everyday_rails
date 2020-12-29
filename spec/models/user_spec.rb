require 'rails_helper'

RSpec.describe User, type: :model do
  it('has a valid factory') do
    expect(build(:user)).to be_valid
  end

  it('is valid with email, password, first_name, last_name') do
    user = build(:user)
    expect(user).to be_valid
  end

  it('is invalid without first_name') do
    user = build(:user, first_name: nil)
    user.valid?
    expect(user.errors[:first_name][0]).to eq("can't be blank")
  end

  it('is invalid without last_name') do
    user = build(:user, last_name: nil)
    user.valid?
    expect(user.errors[:last_name][0]).to eq("can't be blank")
  end

  it('is invalid with a duplicate email address') do
    other_user = create(:user)
    
    user = build(:user, email: other_user.email)
    user.valid?
    expect(user.errors[:email][0]).to eq('has already been taken')
  end

  it("returns a user's full name as a string") do
    user = build(:user)

    expect(user.name).to eq(user.first_name + ' ' + user.last_name)
  end
end
