FactoryBot.define do
  factory :note do
    message { 'message' }
    association(:project)
    user { project.owner }
  end
end
