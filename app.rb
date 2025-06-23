# frozen_string_literal: true

require_relative 'formatter'

# Rack application for handling requests
class TimeApp
  def call(env)
    params = Rack::Utils.parse_nested_query(env['QUERY_STRING'])
    return [400, {}, ['Not found (404)']] if params['format'].to_s.empty?

    formatter = TimeFormatter.new(params['format'])
    status = formatter.valid? ? 200 : 400
    body = [
      formatter.valid? ? formatter.formatted_time : formatter.error_message
    ]
    [status, {}, body]
  end
end
