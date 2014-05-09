module Drydock
  class Supervisor
    attr_accessor :job, :preconditions, :shared_data, :job_status, :commands
    attr_reader :template, :destination, :generated_commands

    def initialize(jobs, preconditions, template, destination)
      @job = jobs
      @preconditions = preconditions
      @shared_data = {}

      @template = template
      @destination = destination

      @job_status = {}
      @job.keys.each do |key|
        @job_status[key] = :incomplete
      end

      @command_mutex = Mutex.new
      @commands = []

      @worker_mutex = Mutex.new
      @worker_count = 1
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

      generate_readme
      generate_template
    end

    def generate_template
      @generated_commands = @commands.join("\n")
      File.open(@template, 'r') do |erbfile|
        erb = ERB.new(erbfile.read)
        File.open(File.join(@destination, 'Dockerfile'), 'w') do |f|
          f.write erb.result(binding)
        end
      end
    end

    def generate_readme
      text = "This dockerfile has been generated by the Drydock gem.  Good Luck.  You will probably need it."
      File.open(@destination + "/README.md", 'w') do |file|
        file.write(text)
      end
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

    def push_commands(commands)
      @command_mutex.synchronize do
        @commands += commands
      end
    end
  end
end
