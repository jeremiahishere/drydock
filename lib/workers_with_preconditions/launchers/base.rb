module WorkersWithPreconditions
  module Launcher
    class Base
      def initialize
        @jobs = {}
        @preconditions = {}
        setup
      end

      def setup
        throw "Setup must be overriden"
      end

      def run
        supervisor = WorkersWithPreconditions::Supervisor.new(@jobs, @preconditions)
        supervisor.start
      end

      def add_job(identifier, klass, config, preconditions = {})
        @jobs[identifier] = klass.new(config)
        @preconditions[identifier] = preconditions
      end
    end
  end
end
