# frozen_string_literal: true

FactoryBot.define do
  factory :topic do
    name { Faker::Ancient.hero }
    validation_date { Faker::Date.between(2.days.ago, Date.today) }
    note { Faker::Lorem.sentence }
    response { Faker::Lorem.word }
  end
end
