class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.text :description, null: false
      t.timestamps
    end
    add_reference :questions, :quiz, null: false, foreign_key: {on_delete: :cascade}
  end
end
