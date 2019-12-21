class AddNotInterestedToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :uninterested, :text, array: true, default: []
  end
end
