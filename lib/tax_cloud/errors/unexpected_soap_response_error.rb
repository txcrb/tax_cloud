# encoding: utf-8
module TaxCloud #:nodoc:
  module Errors #:nodoc:
    # This error is raised when TaxCloud returns an
    # unexpected SOAP response.
    class UnexpectedSoapResponse < TaxCloudError
      # === Parameters
      # [raw] Raw data from the SOAP response.
      # [key] Expected key in the SOAP response.
      # [chain] Complete SOAP response chain in which the key could not be found.
      def initialize(raw, key, chain)
        super(compose_message('unexpected_soap_response',
                              key: key,
                              raw: raw,
                              chain: chain
                             ))
      end
    end
  end
end
