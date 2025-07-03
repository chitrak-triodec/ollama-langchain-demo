# frozen_string_literal: true

class LlmClient
  def initialize
    @llm = Langchain::LLM::Ollama.new(
      url: 'http://127.0.0.1:11434',
      default_options: {
        model: 'phi:latest',
        chat_model: 'phi:latest',
        completion_model: 'phi:latest',
        embedding_model: 'phi:latest'
      }
    )
  end

  def chat(prompt)
    response = @llm.chat(
      messages: [
        { role: 'user', content: prompt }
      ]
    )

    response.raw_response['message']['content']
  end

  def chat_history(messages)
    Faraday.default_connection_options = Faraday::ConnectionOptions.new({ timeout: 1000 })
    full_response = String.new

    @llm.chat(
      messages: messages,
      stream: true
    ) do |chunk|
      # binding.pry
      next unless chunk.raw_response["message"] && chunk.raw_response["message"]["content"].present?

      text = chunk.raw_response["message"]["content"]

      Turbo::StreamsChannel.broadcast_append_to(
        "assistant_stream",
        target: "streamed_reply",
        partial: "chat_histories/stream_chunk",
        locals: { chunk: text }
      )

      full_response << text
    end

    full_response
  end
end
