class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.string :store_path
      t.string :file_name
      t.references :user
      t.boolean :avatar
      t.timestamps
    end
  end
end
