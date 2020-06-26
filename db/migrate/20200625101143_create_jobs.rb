class CreateJobs < ActiveRecord::Migration[6.0]
  def change
    create_table :jobs do |t|
      t.string :job_id, null: false
      t.string :status, default: "processing", null: false
      t.string :filename, null: false

      t.timestamps
    end
    add_reference :jobs, :user, null: false, foreign_key: {on_delete: :cascade}
  end
end
