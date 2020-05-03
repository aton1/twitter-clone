FactoryBot.define do
  factory :tweeet do
    tweeet { Faker::ChuckNorris.fact }
    user_id { "1" }
  end
end
