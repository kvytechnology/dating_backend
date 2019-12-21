class AddPotentialMatchToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :potentials, :text, array: true, default: []
  end
end
