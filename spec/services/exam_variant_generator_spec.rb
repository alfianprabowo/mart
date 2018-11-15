require 'spec_helper'

describe ExamVariantGenerator do

  describe '#generate' do
    let!(:training){ create :training }
    let!(:topic_1) { create :topic }
    let!(:topic_2) { create :topic }

    let!(:questions_1) { create_list :question, 10, :with_answers, topic: topic_1 }
    let!(:questions_2) { create_list :question, 10, :with_answers, topic: topic_2 }
    let!(:questions_3) { create_list :question, 10, :with_answers, topic: topic_2 }
    let!(:number_of_variant) { 2 }
    # let!(:topics) do
      # [
        # { topic_id: topic_1.id, level: 0,  number: 5 },
        # { topic_id: topic_2.id, level: 1,  number: 5 }
      # ]
    # end
    let(:exam_variant_info) do
      {
        number_of_variant: 2,
        topic_combinations: [
          { topic_id: topic_1.id, level: 0, number_of_question: 5 },
          { topic_id: topic_2.id, level: 1, number_of_question: 5 }
        ],
        training_id: training.id
      }
    end

    it 'should assign number of topics' do
      exam_creator = ExamVariantGenerator.new exam_variant_info
      exam_creator.generate

      expect(ExamVariant.count).to eq number_of_variant
    end
  end
end
