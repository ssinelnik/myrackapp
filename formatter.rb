# frozen_string_literal: true

# Business logic of time formatting
class TimeFormatter
  FORMAT_MAP = {
    'year' => '%Y',
    'month' => '%m',
    'day' => '%d',
    'hour' => '%H',
    'minute' => '%M',
    'second' => '%S'
  }.freeze

  def initialize(format_string)
    @formats = format_string.to_s.split(',')
    @unknown_formats = @formats - FORMAT_MAP.keys
  end

  def valid?
    @unknown_formats.empty?
  end

  def formatted_time
    time = Time.now
    @formats.map { |format| time.strftime(FORMAT_MAP[format]) }.join('-')
  end

  def error_message
    "Unknown time format [#{@unknown_formats.join(', ')}]"
  end
end
