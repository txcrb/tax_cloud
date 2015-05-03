# encoding: utf-8
module TaxCloud #:nodoc:
  module Errors #:nodoc:
    # This error is raised when the TaxCloud service
    # returns an error from an API.
    class ApiError < TaxCloudError
      # === Parameters
      # [message] Error message.
      # [raw] Raw data from the SOAP response.
      def initialize(message, raw)
        super(compose_message('api_error',
                              message: message,
                              raw: raw
                             ))
      end
    end
  end
end
