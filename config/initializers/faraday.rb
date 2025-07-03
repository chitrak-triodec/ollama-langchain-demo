# frozen_string_literal: true

Faraday.new do |faraday|
  faraday.options.timeout = 240 # seconds
  faraday.options.open_timeout = 120 # seconds
end
