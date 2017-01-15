FactoryGirl.define do
  factory :observation do
    temperature 0
    pressure 10
    humidity 20
    created_at { Time.current }
  end
end
