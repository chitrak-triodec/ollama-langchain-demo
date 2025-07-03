class LlmClient
  def initialize
    @llm = Langchain::LLM::Ollama.new(
    url: "http://127.0.0.1:11434",
    default_options: {
        model: "phi:latest",
        chat_model: "phi:latest",
        completion_model: "phi:latest",
        embedding_model: "phi:latest"#,
        # request: {
        #   open_timeout: 5,   # open TCP timeout
        #   timeout: 120       # read timeout
        # },

    }
    )
  end

  def chat(prompt)
    # Faraday.default_connection_options = Faraday::ConnectionOptions.new({timeout: 1000})
    # binding.pry
    response = @llm.chat(
      messages: [
        { role: "user", content: prompt }
      ]
    )
    # binding.pry
    # response["message"]["content"]
    response.raw_response["message"]["content"]
  end

  def chat_history(messages)
    Faraday.default_connection_options = Faraday::ConnectionOptions.new({timeout: 1000})
    # binding.pry
    response = @llm.chat(
      messages: messages
    )

    response.raw_response["message"]["content"]
  end
end
