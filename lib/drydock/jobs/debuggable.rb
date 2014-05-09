module Drydock
  module Job
    class Debuggable < ::Drydock::Job::Base
      def docker_commands
        [
          "RUN echo 'root:updog'|chpasswd",
          "ADD bash_scripts/run.sh /run.sh",
          "RUN chmod 755 /*.sh"
        ]
      end
    end
  end
end
