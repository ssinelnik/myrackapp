class TimeApp
  def call(env)
    return path_not_found_response unless valid_path?(env)
    return missing_format_response unless format_provided?(env)

    formats = extract_formats(env)
    return invalid_format_response(formats) unless valid_formats?(formats)

    process_time_request(formats)
  end

  private

  def valid_path?(env)
    env['PATH_INFO'] == '/time'
  end

  def path_not_found_response
    [404, {'Content-Type' => 'text/plain'}, ['Not found']]
  end

  def format_provided?(env)
    !extract_format_param(env).nil?
  end

  def missing_format_response
    [200, {'Content-Type' => 'text/plain'}, ['Please provide a format parameter']]
  end

  def extract_formats(env)
    extract_format_param(env).split(',')
  end

  def extract_format_param(env)
    params = Rack::Utils.parse_nested_query(env['QUERY_STRING'])
    params['format']
  end

  def valid_formats?(formats)
    unknown_formats(formats).empty?
  end

  def unknown_formats(formats)
    valid_format_list = ['year', 'month', 'day', 'hour', 'minute', 'second']
    formats - valid_format_list
  end

  def invalid_format_response(formats)
    unknown = unknown_formats(formats)
    [400, {'Content-Type' => 'text/plain'},
     ["Unknown time format [#{unknown.join(', ')}]"]]
  end

  def process_time_request(formats)
    setup_format_map
    @result = format_current_time(formats)
    [status, headers, body]
  end

  def format_current_time(formats)
    time = Time.now
    formats.map { |format| time.strftime(@format_map[format]) }
  end

  def setup_format_map
    @format_map = {
      'year' => '%Y',
      'month' => '%m',
      'day' => '%d',
      'hour' => '%H',
      'minute' => '%M',
      'second' => '%S'
    }
  end

  def status
    200
  end

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  def body
    [@result.join('-')]
  end
end
