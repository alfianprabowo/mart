# frozen_string_literal: true

FactoryBot.define do
  factory :user_training do
    user { create :user }
    training { create :training }
    registration_number { Faker::IDNumber.valid }
  end
end
