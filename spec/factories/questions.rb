# frozen_string_literal: true

FactoryBot.define do
  factory :question do
    level { [:mudah, :sedang, :sulit].sample }
    quest { "#{Faker::Lorem.sentence}?" }
    validation_date { rand(1..100).days.from_now }
    note { Faker::Lorem.sentence }
    topic { create(:topic) }

    trait :with_answers do
      after(:create) do |question, _evaluator|
        answers = create_list :answer, 4, question: question, correct: false

        correct_answer = answers.sample
        correct_answer.correct = true
        correct_answer.save
      end
    end
  end
end
