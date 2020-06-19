class CreateAttemptAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :attempt_answers do |t|
      t.string :answer, null: false

      t.timestamps
    end
    add_reference :attempt_answers, :question, null: false, foreign_key: {on_delete: :cascade}
    add_reference :attempt_answers, :attempt, null: false, foreign_key: {on_delete: :cascade}
    add_index :attempt_answers, [:question_id, :attempt_id], :unique => true
  end
end
