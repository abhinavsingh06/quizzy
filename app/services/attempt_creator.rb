class AttemptCreator < ApplicationService
  attr_reader :participant_attributes, :quiz, :attempt

  def initialize(participant_attributes, quiz)
    @participant_attributes = participant_attributes
    @quiz = quiz
  end

  def call
    begin
      ActiveRecord::Base.transaction do
        @participant = User.where(email: @participant_attributes[:email]).first_or_initialize(@participant_attributes.except(:email))
        @participant.save!

        @attempt = @participant.attempts.where(quiz_id: @quiz).first_or_initialize
        @attempt.save!
      end
    rescue ActiveRecord::RecordInvalid
      return OpenStruct.new(success?: false, errors: @participant.errors.full_messages) unless @attempt
      return OpenStruct.new(success?: false, errors: @attempt.errors.full_messages)
    end
    OpenStruct.new(success?: true, attempt: @attempt)
  end
end
