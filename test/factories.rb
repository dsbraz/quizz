FactoryGirl.define do
  factory :team do
    sequence(:username) { |n| "team#{n}" }
    password "secret"
    password_confirmation { |u| u.password }
  end

  factory :player do
    sequence(:username) { |n| "player#{n}" }
    password "secret"
    password_confirmation { |u| u.password }
    association :team
  end

  factory :track do
    name "track"
  end

  factory :question do
    name "question"
    association :track
  end

  factory :answer do
    json_value "given answer"
    association :question
    association :player
  end
end
