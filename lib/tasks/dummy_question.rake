# frozen_string_literal: true

namespace :dummy_question do
  desc 'Populate question'
  task populate: :environment do
    next unless is_question_empty?
    next if is_topic_empty?

    topic_ids = Topic.select(:id).all
    levels = [:mudah, :sedang, :sulit]
    prefix = ['Apakah', 'Bagaimana', 'Jika', 'Mengapa']
    20.times.each do
      question = Question.create(
        level: levels.sample, 
        topic_id: topic_ids.sample.id, 
        quest: "#{prefix.sample} #{Faker::Lorem.word} #{Faker::Lorem.word}?",
        validation_date: 3.days.ago
      )

      4.times.each_with_index do |index|
        Answer.create(
          answer: "#{Faker::Lorem.word} #{Faker::Lorem.word}",
          correct: index == 1 ? true : false,
          question_id: question.id
        )
      end
    end
  end

  def is_topic_empty?
    if Topic.count == 0
      Rails.logger.error 'No available topics. Exit'
      return false
    end
    true
  end

  def is_question_empty?
    if Question.count > 0
      Rails.logger.error 'Questions is already exist. Exit'
      return false
    end
    true
  end
end

