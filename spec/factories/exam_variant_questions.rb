# frozen_string_literal: true

FactoryBot.define do
  factory :exam_variant_question do
    order { rand(1..10000) }
    exam_variant { create(:exam_variant) }
    question { create(:question, :with_answers) }

    trait :with_answers do
      after(:create) do |exam_variant_question, _evaluator|
        answers = exam_variant_question.question.answers
        answers.each do |answer|
          create :exam_variant_question_answer,
            exam_variant_question: exam_variant_question
        end
      end
    end
  end
end
