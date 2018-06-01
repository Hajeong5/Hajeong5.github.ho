class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.references :user, index: true
      t.string :title
      t.text :text
      t.boolean :lock
      
      t.timestamps
    end
  end
end
