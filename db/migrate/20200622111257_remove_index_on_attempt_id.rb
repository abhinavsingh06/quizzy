class RemoveIndexOnAttemptId < ActiveRecord::Migration[6.0]
  def change
    remove_index :attempt_answers, :attempt_id
  end
end
