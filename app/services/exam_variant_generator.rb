class ExamVariantGenerator

  def initialize exam_variant_info
    @number_of_variant = exam_variant_info[:number_of_variant]
    @topic_combinations = exam_variant_info[:topic_combinations]
    @training_id = exam_variant_info[:training_id]
  end

  def generate
    @number_of_variant.times.each_with_index do |_variant, variant_index|
      @question_id_list = []
      @topic_combinations.each do |combination|
        @question_id_list.concat(
          get_random_questions(combination[:topic_id],
                               combination[:level],
                               combination[:number_of_question])
        )
      end

      @question_id_list = @question_id_list.shuffle

      exam_variant = ExamVariant.create code: code(index: variant_index), training_id: @training_id

      @question_id_list.each_with_index do |question_id, question_index|
        exam_variant_question = ExamVariantQuestion.create order: question_index+1, question_id: question_id, exam_variant_id: exam_variant.id

        answers = get_random_answers question_id
        answers.each_with_index do |answer_id, answer_index|
          exam_variant_question_answer = ExamVariantQuestionAnswer.create order: answer_index+1, exam_variant_question_id: exam_variant_question.id, answer_id: answer_id
        end
      end
    end
  end

  private

    def code index:
      Time.now.strftime("%Y%m%d%I%M%S").to_s+"-"+@training_id.to_s+"-"+(index).to_s
    end

    def get_random_questions topic_id, level, number_of_question
      questions = Question.where(topic_id: topic_id, level: level).pluck(:id)
      questions.shuffle.first(number_of_question)
    end

    def get_random_answers question_id
      Answer.where(question_id: question_id).pluck(:id).shuffle
    end
end
