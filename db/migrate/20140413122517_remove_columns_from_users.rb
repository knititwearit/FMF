class RemoveColumnsFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :email, :password_digest
  end
end
