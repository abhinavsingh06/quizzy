class AddCorrectAnswersCountToAttempts < ActiveRecord::Migration[6.0]
  def change
    add_column :attempts, :correct_answers_count, :integer, default: 0, null: false
  end
end
