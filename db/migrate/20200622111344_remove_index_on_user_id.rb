class RemoveIndexOnUserId < ActiveRecord::Migration[6.0]
  def change
    remove_index :attempts, :user_id
  end
end
