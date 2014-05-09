module Drydock
  class Worker
    def initialize(index, supervisor, mutex)
      @index = index
      @supervisor = supervisor
      @mutex = mutex
    end

    def run
      id = start_next_job
      # bad fix for the problem
      # the real problem is that you need the mutex once for supervisor.all_jobs_finished and again for start_next_job
      # and nothing can run in between the two syncrhonize blocks
      # it is an easy fix but I am moving on for now.  Sorry.
      return if !id

      copy_files_to_destination(@supervisor.job[id])
      update_template(@supervisor.job[id])
      finish_job(id)
    end

    def copy_files_to_destination(job)
      # make the directory in job.helper_dir
      target = File.join(@supervisor.destination, job.helper_target_dir)
      Dir.mkdir(target) unless Dir.exists?(target)

      # loop through job.helper_files
      job.helper_files.each do |source_file|
        # copy from original location to target location
        filename = source_file.split('/').last
        target_file = File.join(target, filename)
        `cp #{source_file} #{target_file}` # I am pretty sure that you have to shell out here if this is running with multiple threads
      end
    end

    def update_template(job)
      @supervisor.push_commands(job.docker_commands)
    end

    def start_next_job
      @mutex.synchronize do
        ids = available_job_ids
        return nil if ids.empty?

        ids.each do |id|
          if preconditions_met?(id)
            start_job(id)
            return id
          end
        end
        return nil
      end
    end

    def finish_job(identifier)
      @mutex.synchronize do
        @supervisor.shared_data[identifier] = true
        @supervisor.job_status[identifier] = :complete
      end
    end

    def available_job_ids
      @supervisor.job_status.select { |key, value| value == :incomplete }.keys
    end

    def preconditions_met?(identifier)
      if @supervisor.preconditions[identifier].empty?
        return true
      end

      @supervisor.preconditions[identifier].each_pair do |key, value|
        return false unless @supervisor.shared_data.has_key? key
        return false unless @supervisor.shared_data[key] == value
      end

      return true 
    end

    def start_job(identifier)
      @supervisor.job_status[identifier] = :in_progress
    end
  end
end
