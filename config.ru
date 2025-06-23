# frozen_string_literal: true

require_relative 'middleware/runtime'
require_relative 'middleware/logger'
require_relative 'app'

ROUTES = {
  '/time' => TimeApp.new
}.freeze

use Runtime
use AppLogger, logdev: File.expand_path('log/app.log', __dir__)
use Rack::ContentType, 'text/plain'
run Rack::URLMap.new(ROUTES)
run TimeApp.new
