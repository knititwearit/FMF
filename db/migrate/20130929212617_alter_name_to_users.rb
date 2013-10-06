class AlterNameToUsers < ActiveRecord::Migration
  def change
    change_column(:users, :name, :text)
  end
end
