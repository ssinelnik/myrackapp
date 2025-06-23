# frozen_string_literal: true

require_relative 'formatter'

# Rack application for handling requests
class TimeApp
  def call(env)
    return path_not_found_response unless env['PATH_INFO'] == '/time'

    params = Rack::Utils.parse_nested_query(env['QUERY_STRING'])
    format_string = params['format']

    return missing_format_response if format_string.nil? || format_string.empty?

    process_time_request(format_string)
  end

  private

  def process_time_request(format_string)
    formatter = TimeFormatter.new(format_string)

    if formatter.valid?
      [200, {}, [formatter.formatted_time]]
    else
      [400, {}, [formatter.error_message]]
    end
  end

  def path_not_found_response
    [404, {}, ['Not found']]
  end

  def missing_format_response
    [400, {}, ['Please provide a format parameter']]
  end
end
