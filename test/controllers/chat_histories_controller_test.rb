# frozen_string_literal: true

require 'test_helper'

class ChatHistoriesControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get chat_histories_index_url
    assert_response :success
  end

  test 'should get create' do
    get chat_histories_create_url
    assert_response :success
  end
end
