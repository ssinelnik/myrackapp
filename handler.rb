# frozen_string_literal: true

require_relative 'middleware/runtime'
require_relative 'middleware/logger'
require_relative 'app'

app = Rack::Builder.new do
  use Runtime
  use AppLogger
  run TimeApp.new
end

Rack::Handler::WEBrick.run app
