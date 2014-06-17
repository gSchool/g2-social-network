class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :sender
      t.integer :receiver
      t.string :subject
      t.text :body
      t.timestamp
    end
  end
end
