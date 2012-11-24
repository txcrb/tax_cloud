# encoding: utf-8
module TaxCloud
  module Errors

    # This error is raised when TaxCloud returns an error from an API.
    class ApiError < TaxCloudError

      # Create the new error.
      #
      # @example Create the error.
      #   ApiError.new(message, raw)
      #
      # @since 1.0.0
      def initialize(message, raw)
        super(compose_message("api_error", {
          :message => message,
          :raw => raw
        }))
      end
    end
  end
end