require 'spec_helper'

describe ExamVariantsController do
  let(:user) { create :user, level: User::ADMIN }

  describe 'POST #create' do
    let!(:topic_1){ create :topic }
    let!(:questions_1) { create_list :question, 10, topic: topic_1, level: 0 }

    let!(:topic_2){ create :topic }
    let!(:questions_2) { create_list :question, 10, topic: topic_2, level: 1 }

    let!(:training){ create :training }

    let(:topic_combination_params) do
      {
        "0" => { topic_id: topic_1.id.to_s, level: "0",  number_of_question: "5" },
        "1" => { topic_id: topic_2.id.to_s, level: "1",  number_of_question: "5" }
      }
    end
    let(:topic_combination) do
      [
        { topic_id: topic_1.id, level: 0,  number_of_question: 5 },
        { topic_id: topic_2.id, level: 1,  number_of_question: 5 }
      ]
    end

    it 'assign topic_combination' do

    end

    it 'call generate from ExamGenerator' do
      sign_in_as user

      generator = instance_double ExamVariantGenerator
      generator_params = {
        training_id: training.id,
        topic_combinations: topic_combination,
        number_of_variant: 2
      }

      expect(ExamVariantGenerator)
        .to receive(:new)
        .with(generator_params)
        .and_return generator
      expect(generator).to receive(:generate)

      post :create, params: {
        exam_variants: {
          training_id: "#{training.id}",
          topic_combinations: topic_combination_params,
          number_of_variant: "2"
        }
      }

      expect(TrainingTopic.find_by(
        training_id: training.id,
        number_of_question: 5,
        topic_id: topic_1.id
      )).to be_present
      expect(TrainingTopic.find_by(
        training_id: training.id,
        number_of_question: 5,
        topic_id: topic_1.id
      )).to be_present
    end
  end
end
