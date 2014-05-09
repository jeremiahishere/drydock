module Drydock
  module Job
    class Printer < ::Drydock::Job::Base
      def initialize(config)
        @message = config[:message]
      end

      def helper_files
        ["helper.sh"]
      end

      def docker_commands
        [
          "RUN echo '#{@message}'",
          "RUN ./printer/helper.sh",
        ]
      end
    end
  end
end
