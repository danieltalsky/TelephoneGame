Rails.application.configure do
  # Add some sensible caching headers all assets. Sometimes Nginx adds these, but not always.
  config.static_cache_control = 'public, max-age=31536000'
  config.public_file_server.headers = {
    'Cache-Control' => 'public, max-age=31536000',
    'Expires' => 1.year.from_now.to_formatted_s(:rfc822)
  }
end
