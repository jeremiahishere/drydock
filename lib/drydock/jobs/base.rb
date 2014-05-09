module Drydock
  module Job
    class Base
      
      # list of files that should be copied into the destination folder
      # they will automatically be copied to destination/name_of_job/<filename>.sh
      def copy_files
        []
      end

      # commands to add to the docker file
      # each command should go in it's own string and they will be copied to the dockerfile in the order of the array
      def docker_commands
        []
      end
    end
  end
end
