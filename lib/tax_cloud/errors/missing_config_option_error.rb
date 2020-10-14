# frozen_string_literal: true

module TaxCloud #:nodoc:
  module Errors #:nodoc:
    # This error is raised when a configuration
    # option is missing.
    class MissingConfigOption < TaxCloudError
      # === Parameters
      # [name] The attempted config option name.
      def initialize(name)
        super(
          compose_message(
            'missing_config_option',
            name: name
          )
        )
      end
    end
  end
end
