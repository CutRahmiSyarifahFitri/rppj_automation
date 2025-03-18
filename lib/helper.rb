def generate_timestamp(timestamp_format)
  Time.now.strftime(timestamp_format)
end

# Helper method to strip ANSI escape codes
def strip_ansi_escape_codes(text)
  text.gsub(/\e\[([;\d]+)?m/, '')
end
