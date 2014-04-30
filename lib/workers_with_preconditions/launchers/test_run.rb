module WorkersWithPreconditions
  module Launcher
    class TestRun < ::WorkersWithPreconditions::Launcher::Base
      def setup
        add_job(:first_job, 
          WorkersWithPreconditions::Job::Printer, 
          {:message => 'hello world'}
        )
        add_job(:last_job, 
          WorkersWithPreconditions::Job::Printer, 
          {:message => 'goodbye world'}, 
          { :first_job => true, :middle_job => true }
        )
        add_job(:middle_job, 
          WorkersWithPreconditions::Job::Printer, 
          {:message => 'working'}, 
          { :first_job => true }
        )

        add_job(:job_4, 
          WorkersWithPreconditions::Job::Printer, 
          {:message => 'hello world 4'}
        )
        add_job(:job_5, 
          WorkersWithPreconditions::Job::Printer, 
          {:message => 'hello world 5'}
        )
        add_job(:job_6, 
          WorkersWithPreconditions::Job::Printer, 
          {:message => 'hello world 6'}
        )
        add_job(:job_7, 
          WorkersWithPreconditions::Job::Printer, 
          {:message => 'hello world 7'}
        )
        add_job(:job_8, 
          WorkersWithPreconditions::Job::Printer, 
          {:message => 'hello world 8'}
        )
        add_job(:job_9, 
          WorkersWithPreconditions::Job::Printer, 
          {:message => 'hello world 9'}
        )
        add_job(:job_10, 
          WorkersWithPreconditions::Job::Printer, 
          {:message => 'hello world 10'}
        )
        add_job(:job_11, 
          WorkersWithPreconditions::Job::Printer, 
          {:message => 'hello world 11'}
        )
      end
    end
  end
end
