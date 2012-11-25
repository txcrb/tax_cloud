# encoding: utf-8
module TaxCloud
  module Errors

    # Raised when TaxCloud returns an unexpected SOAP response.
    class UnexpectedSoapResponse < TaxCloudError

      # Create the new error.
      # @param [ String ] raw Raw data from the SOAP response.
      # @param [ String ] key Expected key in the SOAP response.
      # @param [ String ] chain Complete SOAP response chain in which the key could not be found.
      def initialize(raw, key, chain)
        super(compose_message("unexpected_soap_response", {
          :key => key,
          :raw => raw,
          :chain => chain
        }))
      end

    end
  end
end