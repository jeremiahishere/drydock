module Drydock
  class Supervisor
    attr_accessor :job, :preconditions, :shared_data, :job_status

    def initialize(jobs, preconditions)
      @job = jobs
      @preconditions = preconditions
      @shared_data = {}

      @job_status = {}
      @job.keys.each do |key|
        @job_status[key] = :incomplete
      end

      @worker_mutex = Mutex.new

      @worker_count = 3
      @worker_threads = []
      @workers = []
    end

    def start
      @worker_count.times do |index|
        @worker_threads << Thread.new(index) do |thread_index|
          worker = create_worker(index)

          while(!all_jobs_finished?)
            worker.run
            sleep(1)
          end
        end
      end
      @worker_threads.each(&:join)
    end

    def create_worker(index)
      worker = Worker.new(index, self, @worker_mutex)
      @workers << worker
      worker
    end

    def all_jobs_finished?
      @worker_mutex.synchronize do
        @job_status.select { |id, value| value != :complete }.empty?
      end
    end
  end
end
