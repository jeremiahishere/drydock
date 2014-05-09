module Drydock
  module Launcher
    class TestRun < ::Drydock::Launcher::Base
      def setup
        add_job(
          name: :first_job, 
          job: Drydock::Job::Printer, 
          config: {:message => 'hello world'}
        )
#        add_job(
#          name: :last_job, 
#          job: Drydock::Job::Printer, 
#          config: {:message => 'goodbye world'}, 
#          preconditions: { :first_job => true, :middle_job => true }
#        )
#        add_job(
#          name: :middle_job, 
#          job: Drydock::Job::Printer, 
#          config: {:message => 'working'}, 
#          preconditions: { :first_job => true }
#        )

        add_job(
          name: :setup_debugging,
          job: Drydock::Job::Debuggable
        )
      end
    end
  end
end
