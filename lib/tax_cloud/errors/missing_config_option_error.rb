# encoding: utf-8
module TaxCloud
  module Errors

    # This error is raised when a configuration option is missing.
    class MissingConfigOption < TaxCloudError

      # Create the new error.
      #
      # @example Create the new error.
      #   MissingConfigOption.new(:name, [ :option ])
      #
      # @param [ Symbol, String ] name The attempted config option name.
      #
      # @since 3.0.0
      def initialize(name)
        super(
          compose_message(
            "missing_config_option",
            { name: name }
          )
        )
      end
    end
  end
end