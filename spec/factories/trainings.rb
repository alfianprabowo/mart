# frozen_string_literal: true

FactoryBot.define do
  factory :training do
    start_date { rand(5..10).days.from_now }
    end_date { rand(15..20).days.from_now }
    address { Faker::Address.full_address }
    validation_date { Faker::Date.between(2.days.ago, 2.days.from_now)  }
    description { Faker::Lorem.sentence }
    theme { Faker::Artist.name }
    venue { Faker::University.name }
    photo { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/logo_image.jpg'), 'image/jpeg') }
    receipt { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/logo_image.jpg'), 'image/jpeg') }
    print_date { [Faker::Date.between(2.days.ago, DateTime.now), nil].sample }
    instructor { create :user }
    user { create :user }
    room_size { "#{Faker::Number.number(2)}m2" }
    room_total { Faker::Number.number(1) }
  end
end
