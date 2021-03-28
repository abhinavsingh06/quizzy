class QuestionOptionValidator < ActiveModel::Validator
  
  def validate(record)
    correct_option = false

    unless record.options.present?
      return record.errors.add(:options, "can't be blank")
    end

    record.options.each do |option|
      if option["is_correct"]
        correct_option = option["is_correct"]
      end

      if option["value"].length < 1
        record.errors.add(:option, "should have a valid length")
      end
    end

    # unless correct_option
    #   record.errors.add(:option, "should have a correct answer")
    # end
  end
end
