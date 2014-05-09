module Drydock
  module Job
    class Base

      def helper_source_dir
        # stolen from the rails underscore method
        # does not include the namespaces
        self.class.name.split('::').last.
          gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
          gsub(/([a-z\d])([A-Z])/,'\1_\2').
          tr("-", "_").
          downcase
      end

      # can be overridden if you are feeling cool
      def helper_target_dir
        helper_source_dir
      end
      
      # list of files that should be copied into the destination folder
      # they will automatically be copied to destination/name_of_job/<filename>.sh
      def helper_files
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
