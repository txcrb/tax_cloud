# encoding: utf-8
module TaxCloud
  module Errors

    # Raised when TaxCloud returns an error from an API.
    # @param [ String ] message Error message.
    # @param [ String ] raw Raw data from the SOAP response.
    class ApiError < TaxCloudError
      def initialize(message, raw)
        super(compose_message("api_error", {
          :message => message,
          :raw => raw
        }))
      end
    end

  end
end