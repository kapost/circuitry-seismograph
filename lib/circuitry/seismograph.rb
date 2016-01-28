require 'circuitry/seismograph/version'
require 'circuitry/middleware/seismograph'
require 'circuitry'

Circuitry.config do |config|
  config.publisher_middleware.add Circuitry::Middleware::Seismograph, stat: 'publisher'
  config.subscriber_middleware.add Circuitry::Middleware::Seismograph, stat: 'subscriber'
end
