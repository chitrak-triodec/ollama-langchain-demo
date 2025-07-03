# frozen_string_literal: true

class ChatMessage < ApplicationRecord
  validates :role, :content, :conversation_id, presence: true
end
