# frozen_string_literal: true

namespace :dummy_training do
  desc 'Populate training'
  task populate: :environment do
    next if is_question_empty?

    create_training is_future: true, variants: ['4','2']
    create_training is_future: false, variants: ['3','1']
  end

  def is_question_empty?
    return false if Question.count > 0

    Rails.logger.error 'No available questions. Exit'
    return true
  end

  def create_training is_future:, variants:nil, date:nil, address:nil
    if is_future
      date = 5.days.after
      address = 'Jakarta'
    else
      date = 5.days.before
      address = 'Bandung'
    end

    training = Training.new(
      start_date: rand(5..10).days.from_now,
      end_date: rand(15..20).days.from_now,
      address: Faker::Address.full_address,
      validation_date: [nil, Faker::Date.between(2.days.ago, DateTime.now)].sample ,
      description: Faker::Lorem.sentence,
      theme: Faker::Commerce.department,
      venue: Faker::University.name,
      remote_photo_url: 'https://asset.kompas.com/crop/100x78:900x612/750x500/data/photo/2018/04/04/3482680610.jpg',
      remote_receipt_url: 'https://contohsuratindonesia.com/wp-content/uploads/2016/10/contoh-Surat-Perjanjian-Sewa-Kontrak-Rumah.jpg',
      print_date: [nil, Faker::Date.between(2.days.ago, DateTime.now)].sample,
      instructor: User.find_by(level: User::INSTRUCTOR),
      user: User.find_by(level: User::INSTITUTION),
      room_size: "#{Faker::Number.number(2)}m2",
      room_total: Faker::Number.number(1)
    )
    training.save!

    variants.each do |variant_code|
      create_variant training, variant_code
    end
  end

  def create_variant training, variant_code
    variant = ExamVariant.create(
      code: variant_code,
      training: training
    )
    create_variant_question variant
  end

  def create_variant_question exam_variant
    order = 1

    topics = Topic.limit(2)
    topics.each_with_index do |topic, topic_index|

      create_training_topic exam_variant.training, topic

      questions = topic.questions
      questions.each_with_index do |question, question_index|

        # order = ((topic_index) * topic.questions.count ) + (question_index + 1)
        exam_variant_question = ExamVariantQuestion.new(
          order: order,
          question: question,
          exam_variant: exam_variant
        )
        exam_variant_question.save!

        create_exam_question_answer exam_variant_question, question
        order += 1
      end
    end
  end

  def create_exam_question_answer exam_variant_question, question
    answers = question.answers
    answers.each_with_index do |answer, index|
      ExamVariantQuestionAnswer.create(
        order: index,
        answer: answer,
        exam_variant_question_id: exam_variant_question.id
      )
    end
  end

  def create_training_topic training, topic
    return if TrainingTopic.find_by(topic: topic, training: training).present?

    TrainingTopic.create training: training,
      topic: topic,
      number_of_question: topic.questions.count
  end
end
