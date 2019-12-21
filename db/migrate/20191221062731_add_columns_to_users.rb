class AddColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string
    add_column :users, :bio, :text
    add_column :users, :age, :integer
    add_column :users, :gender, :string
  end
end
