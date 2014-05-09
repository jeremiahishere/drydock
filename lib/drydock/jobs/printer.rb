module Drydock
  module Job
    class Printer < ::Drydock::Job::Base
      def initialize(config)
        @message = config[:message]
      end

      def copy_files
        ["printer/helper.sh"]
      end

      def docker_commands
        [
          "RUN echo 'hello'",
          "RUN ./printer/helper.sh",
          "RUN echo 'goodbye'"
        ]
      end
    end
  end
end
