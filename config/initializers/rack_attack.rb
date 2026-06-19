Rack::Attack.blocklist("block php scanners") do |req|
  path = req.path.downcase
  path.end_with?(".php") ||
    path.include?("/wp-") ||
    path.include?("xmlrpc")
end

BLOCKED_PATHS = %w[
  .env .env.local .env.production .env.development
  config.xml config.json config/database.yml
  .git .git/config .git/HEAD .git/index .git/logs/HEAD
  api/.env v1/.env graphql/.env
  .aws/credentials .htaccess

  phpmyadmin phpMyAdmin pma
  administrator
  drupal sites/default
  magento admin_magento

  phpunit vendor/phpunit
  laravel/debugbar telescope/requests
  horizon api/horizon
  _ignition health check_health

  cgi-bin
  server-status server-info
  trace debug phpinfo
  swagger api-docs openapi.json
  actuator health env beans

  .sql .zip .tar.gz .bak .backup
  .ds_store
  .vscode .idea

  robots.txt humans.txt
  ads.txt app-ads.txt
  sitemap.xml.gz
].freeze

Rack::Attack.blocklist("block exploit probes") do |req|
  path = req.path.downcase
  BLOCKED_PATHS.any? { |p| path.include?(p) }
end

Rack::Attack.blocklist("block bare api probes") do |req|
  %w[/api /api/v1 /api/v2 /rest].include?(req.path.chomp("/").downcase)
end

Rack::Attack.blocklist("block sql injection probes") do |req|
  req.query_string&.match?(/union\s+select|select\s+.*\s+from|insert\s+into|delete\s+from|drop\s+table/i)
end

Rack::Attack.safelist("allow-localhost-in-dev") do |req|
  Rails.env.development? && [ "127.0.0.1", "::1" ].include?(req.ip)
end

Rack::Attack.throttle("req/ip", limit: 300, period: 5.minutes) do |req|
  req.ip
end

Rack::Attack.throttle("logins/ip", limit: 10, period: 20.seconds) do |req|
  req.ip if req.path == "/login" && req.post?
end

Rack::Attack.throttle("logins/username", limit: 5, period: 20.seconds) do |req|
  if req.path == "/login" && req.post?
    req.params["username"].to_s.downcase.presence
  end
end

Rack::Attack.blocklist("block repeated failed logins") do |req|
  if req.path == "/login" && req.post?
    Rack::Attack::Allow2Ban.filter("failed-logins/#{req.ip}", maxretry: 5, findtime: 5.minutes, bantime: 1.hour) do
      req.ip
    end
  end
end

Rack::Attack.blocklisted_responder = lambda do |req|
  Rails.logger.warn "[Rack::Attack] Blocked: #{req.env['rack.attack.matched']} ip=#{req.ip} path=#{req.path}"
  [ 403, { "Content-Type" => "text/plain" }, [ "Forbidden" ] ]
end

Rack::Attack.throttled_responder = lambda do |req|
  Rails.logger.warn "[Rack::Attack] Throttled: #{req.env['rack.attack.matched']} ip=#{req.ip} path=#{req.path}"
  [ 429, { "Content-Type" => "text/plain", "Retry-After" => "60" }, [ "Rate limit exceeded" ] ]
end
