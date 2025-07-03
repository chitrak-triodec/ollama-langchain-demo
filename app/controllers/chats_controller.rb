class ChatsController < ApplicationController
  def index; end

  def create
    @prompt = params[:message]
    @reply = LlmClient.new.chat(@prompt)
    puts "=== DEBUG: @reply is: #{@reply.inspect}"
    render :index
  end
end
