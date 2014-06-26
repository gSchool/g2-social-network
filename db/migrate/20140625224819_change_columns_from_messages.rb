class ChangeColumnsFromMessages < ActiveRecord::Migration
  def change
    rename_column :messages, :sender, :sender_id
    rename_column :messages, :receiver, :receiver_id
  end
end
