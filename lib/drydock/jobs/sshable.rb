module Drydock
  module Job
    class Sshable < ::Drydock::Job::Base
      def initialize(config)
      end

      #def helper_files
      #  ["run.sh"]
      #end

      def docker_commands
        [
          %(RUN apt-get update),
          %(RUN DEBIAN_FRONTEND=noninteractive apt-get -y install openssh-server supervisor),
          %(RUN mkdir -p /var/run/sshd),
          %(ADD config_files/ssh_config /etc/ssh/ssh_config),
          %(ADD config_files/sshd_config /etc/ssh/sshd_config),
          %(ADD config_files/supervisord-sshd.conf /etc/supervisor/conf.d/supervisord-sshd.conf),
          %(EXPOSE 22),
          #%(RUN chmod 755 /*.sh),
          #%(CMD ["/run.sh"])
        ]
      end
    end
  end
end
