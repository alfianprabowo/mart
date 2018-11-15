# frozen_string_literal: true

FactoryBot.define do
  factory :exam_variant_question_answer do
    order { rand(1..99) }
    exam_variant_question { create(:exam_variant_question) }
    answer { create(:answer) }
  end
end
