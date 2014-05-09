module Drydock
  module Job
    class Base
      def run
        throw "Run method must be defined"
      end
    end
  end
end
