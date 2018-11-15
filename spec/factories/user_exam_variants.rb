# frozen_string_literal: true

FactoryBot.define do
  factory :user_exam_variant do
    score { (rand(1..100)).to_d }
    user { create :user }
    exam_variant { create :exam_variant }
  end
end
