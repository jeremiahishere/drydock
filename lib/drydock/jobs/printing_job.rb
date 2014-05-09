module Drydock
  module Job
    class Printer < ::Drydock::Job::Base
      def initialize(config)
        @message = config[:message]
      end

      def run
        sleep(1)
        puts @message
      end
    end
  end
end
