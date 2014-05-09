module Drydock
  module Launcher
    class TestRun < ::Drydock::Launcher::Base
      def setup
        add_job(:first_job, 
          Drydock::Job::Printer, 
          {:message => 'hello world'}
        )
        add_job(:last_job, 
          Drydock::Job::Printer, 
          {:message => 'goodbye world'}, 
          { :first_job => true, :middle_job => true }
        )
        add_job(:middle_job, 
          Drydock::Job::Printer, 
          {:message => 'working'}, 
          { :first_job => true }
        )

        add_job(:job_4, 
          Drydock::Job::Printer, 
          {:message => 'hello world 4'}
        )
        add_job(:job_5, 
          Drydock::Job::Printer, 
          {:message => 'hello world 5'}
        )
        add_job(:job_6, 
          Drydock::Job::Printer, 
          {:message => 'hello world 6'}
        )
        add_job(:job_7, 
          Drydock::Job::Printer, 
          {:message => 'hello world 7'}
        )
        add_job(:job_8, 
          Drydock::Job::Printer, 
          {:message => 'hello world 8'}
        )
        add_job(:job_9, 
          Drydock::Job::Printer, 
          {:message => 'hello world 9'}
        )
        add_job(:job_10, 
          Drydock::Job::Printer, 
          {:message => 'hello world 10'}
        )
        add_job(:job_11, 
          Drydock::Job::Printer, 
          {:message => 'hello world 11'}
        )
      end
    end
  end
end
