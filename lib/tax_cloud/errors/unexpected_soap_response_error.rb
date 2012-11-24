# encoding: utf-8
module TaxCloud
  module Errors

    # This error is raised when TaxCloud returns 
    # an unexpected SOAP response.
    class UnexpectedSoapResponse < TaxCloudError

      # Create the new error.
      #
      # @example Create the error.
      #   UnexpectedSoapResponse.new(raw, key, *chain)
      #
      # @since 1.0.0
      def initialize(raw, key, *chain)
        super(compose_message("unexpected_soap_response", {
          :key => key,
          :raw => raw,
          :chain => Array(chain).join("/")
        }))
      end
    end
  end
end