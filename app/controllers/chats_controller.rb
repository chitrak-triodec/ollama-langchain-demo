# frozen_string_literal: true

class ChatsController < ApplicationController
  def index; end

  def create
    @prompt = params[:message]
    @reply = LlmClient.new.chat(@prompt)
    Rails.logger.debug { "=== DEBUG: @reply is: #{@reply.inspect}" }
    render :index
  end
end
