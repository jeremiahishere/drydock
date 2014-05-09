module Drydock
  module Launcher
    class Base
      def initialize(template, destination)
        @jobs = {}
        @preconditions = {}
        @template = template
        FileUtils.mkpath(destination)
        @destination = File.realpath(destination)
        setup
      end

      def setup
        throw "Setup must be overriden"
      end

      def run
        supervisor = Drydock::Supervisor.new(@jobs, @preconditions, @template, @destination)
        supervisor.start
      end

      def add_job(args)
        # todo: upgrade to ruby 2, then use named parameters
        identifier = args[:name]
        klass = args[:job]
        config = args[:config] || {}
        preconditions = args[:preconditions] || {}

        @jobs[identifier] = klass.new(config)
        @preconditions[identifier] = preconditions
      end
    end
  end
end
