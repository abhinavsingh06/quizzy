class CreateQuizzes < ActiveRecord::Migration[6.0]
  def change
    create_table :quizzes do |t|
      t.string :name, null: false

      t.timestamps
    end
    add_reference :quizzes, :user, null: false, foreign_key: {on_delete: :restrict}
  end
end
