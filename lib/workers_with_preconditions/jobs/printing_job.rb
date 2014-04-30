module WorkersWithPreconditions
  module Job
    class Printer < ::WorkersWithPreconditions::Job::Base
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
