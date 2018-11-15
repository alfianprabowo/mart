# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::FunnyName.three_word_name }
    nik { Faker::IDNumber.valid }
    email { Faker::Internet.email }
    level { [0,1,2].sample }
    password { Faker::Lorem.word }
  end
end
