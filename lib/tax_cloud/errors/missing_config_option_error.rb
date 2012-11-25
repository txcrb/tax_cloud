# encoding: utf-8
module TaxCloud
  module Errors

    # Raised when a configuration option is missing.
    class MissingConfigOption < TaxCloudError
      
      # Create the new error.
      # @param [ Symbol, String ] name The attempted config option name.
      def initialize(name)
        super(
          compose_message(
            "missing_config_option",
            { :name => name }
          )
        )
      end
      
    end
  end
end