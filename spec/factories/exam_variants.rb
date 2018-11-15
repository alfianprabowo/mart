# frozen_string_literal: true

FactoryBot.define do
  factory :exam_variant do
    code { rand(1..100) }
    training { create(:training) }
  end
end
