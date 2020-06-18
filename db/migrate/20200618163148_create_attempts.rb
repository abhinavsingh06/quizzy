class CreateAttempts < ActiveRecord::Migration[6.0]
  def change
    create_table :attempts do |t|
      t.boolean :submitted, default: false, null: false
      
      t.timestamps
    end
    add_reference :attempts, :user, null: false, foreign_key: {on_delete: :restrict}
    add_reference :attempts, :quiz, null: false, foreign_key: {on_delete: :cascade}
    add_index :attempts, [:user_id, :quiz_id], :unique => true
  end
end
