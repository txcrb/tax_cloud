# encoding: utf-8
module TaxCloud
  module Errors

    # This error is raised when attempting to create a new client
    # without configuring TaxCloud
    class MissingConfig < TaxCloudError

      # Create the new error.
      #
      # @example Create the error.
      #   MissingConfig.new
      #
      # @since 1.0.0
      def initialize
        super(compose_message("missing_config"))
      end
    end
  end
end