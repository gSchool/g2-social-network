class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :post_body
      t.integer :user_id
      t.index :user_id
      t.timestamps
    end
  end
end
