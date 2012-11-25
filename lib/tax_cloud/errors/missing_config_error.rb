# encoding: utf-8
module TaxCloud
  module Errors
    # This error is raised when attempting to create a new client
    # without configuring TaxCloud
    class MissingConfig < TaxCloudError
      def initialize
        super(compose_message("missing_config"))
      end
    end
  end
end