FactoryBot.define do
  factory(:user, aliases: [:owner]) do
    first_name { 'eiji' }
    last_name { 'kurita' }
    sequence(:email) { |n| "example#{n}@example.com" }
    password { 'password1234' }
  end
end
