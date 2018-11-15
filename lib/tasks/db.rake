# frozen_string_literal: true

namespace :db do
  desc 'Danger delete all data'
  task danger_clean_all_data: :environment do
    ExamVariantQuestionAnswer.delete_all
    ExamVariantQuestion.delete_all
    Answer.delete_all
    Question.delete_all

    UserTraining.delete_all

    UserExamAnswer.delete_all
    UserExamVariant.delete_all
    ExamVariant.delete_all

    TrainingTopic.delete_all
    Training.delete_all

    Topic.delete_all

    User.delete_all
  end
end

