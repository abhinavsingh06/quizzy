class AddIndexToSlug < ActiveRecord::Migration[6.0]
  disable_ddl_transaction!

  def change
    add_index :quizzes, :slug, unique: true, algorithm: :concurrently
  end
end
