class CreateQuestionMultipleChoices < ActiveRecord::Migration[6.0]
  def change
    create_table :question_multiple_choices do |t|
      t.jsonb :options, null: false, default: []
      t.timestamps
    end
    add_reference :question_multiple_choices, :question, null: false, foreign_key: {on_delete: :cascade}
  end
end
