require 'seismograph'

module Circuitry
  module Middleware
    class Seismograph
      attr_reader :namespace, :stat

      def initialize(options = {})
        self.namespace = options.fetch(:namespace, 'circuitry')
        self.stat = options.fetch(:stat)
      end

      def call(topic, _message, &block)
        tags = ["topic:#{topic}"]
        sensor.benchmark(stat, tags: tags, &block)
      rescue StandardError => err
        log.error('Circuitry message processing failed', description: err.message, tags: tags)
        raise err
      end

      private

      attr_writer :namespace, :stat

      def sensor
        @sensor ||= ::Seismograph::Sensor.new(namespace)
      end

      def log
        @log ||= ::Seismograph::Log
      end
    end
  end
end
