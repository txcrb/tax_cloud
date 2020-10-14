# frozen_string_literal: true

module TaxCloud #:nodoc:
  module Errors #:nodoc:
    # This error is raised when attempting to create a new client
    # without configuring TaxCloud.
    class MissingConfig < TaxCloudError
      # Create a new error.
      def initialize
        super(compose_message('missing_config'))
      end
    end
  end
end
