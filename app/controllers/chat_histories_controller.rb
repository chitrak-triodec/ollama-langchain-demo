# app/controllers/chat_histories_controller.rb
class ChatHistoriesController < ApplicationController
  def index
    # Use a persistent conversation ID for this user session
    session[:conversation_id] ||= SecureRandom.uuid

    @chat_history = ChatMessage.where(conversation_id: session[:conversation_id]).order(:created_at)
  end

  def create
    session[:conversation_id] ||= SecureRandom.uuid
    conversation_id = session[:conversation_id]

    prompt = params[:message]

    # Save user message
    ChatMessage.create!(
      role: "user",
      content: prompt,
      conversation_id: conversation_id
    )

    # Get full conversation so far
    messages = ChatMessage.where(conversation_id: conversation_id).order(:created_at).pluck(:role, :content).map do |role, content|
      { role: role, content: content }
    end

    # Send to LLM
    llm_client = LlmClient.new
    reply = llm_client.chat_history(messages)

    # Save assistant reply
    ChatMessage.create!(
      role: "assistant",
      content: reply,
      conversation_id: conversation_id
    )

    redirect_to chat_histories_path
  end

  def reset
    session[:conversation_id] = SecureRandom.uuid
    redirect_to chat_histories_path, notice: "Started a new chat!"
  end
end
