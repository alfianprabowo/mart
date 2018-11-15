# frozen_string_literal: true

FactoryBot.define do
  factory :answer do
    answer { Faker::Coffee.origin }
    correct { [true, false].sample }
    question { create(:question) }
  end
end
