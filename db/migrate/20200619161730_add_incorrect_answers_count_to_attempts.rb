class AddIncorrectAnswersCountToAttempts < ActiveRecord::Migration[6.0]
  def change
    add_column :attempts, :incorrect_answers_count, :integer, default: 0, null: false
  end
end
