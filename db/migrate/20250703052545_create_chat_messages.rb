# frozen_string_literal: true

class CreateChatMessages < ActiveRecord::Migration[8.0]
  def change
    create_table :chat_messages do |t|
      t.string :role, null: false
      t.text :content, null: false
      t.string :conversation_id, null: false

      t.timestamps
    end
    add_index :chat_messages, :conversation_id
  end
end
