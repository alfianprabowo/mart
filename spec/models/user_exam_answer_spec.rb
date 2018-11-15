require 'spec_helper'

describe UserExamAnswer, type: :model do
  context 'has associations' do
    it { should belong_to(:user_exam_variant) }
  end

  context 'has validations' do
    it { should validate_presence_of(:id_question) }
    it { should validate_presence_of(:question) }
    it { should validate_presence_of(:question_order) }
    it { should validate_presence_of(:id_answer) }
    it { should validate_presence_of(:answer) }
    it { should validate_presence_of(:user_exam_variant) }
    it { should validate_inclusion_of(:is_correct).in_array([true, false]) }
  end
end
