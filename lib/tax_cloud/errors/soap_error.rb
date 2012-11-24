# encoding: utf-8
module TaxCloud
  module Errors

    # This error is raised from any failed SOAP operation.
    class SoapError < TaxCloudError

      attr_reader :fault

      # Create the new error.
      #
      # @example Create the error.
      #   SoapError.new
      #
      # @since 1.0.0
      def initialize(e)
        @fault = e
        e.to_hash.tap do |fault|
          fault_code = fault[:fault][:faultcode]
          fault_string = parse_fault(fault[:fault][:faultstring])
          super(compose_message("soap_error", {
            :message => fault_string,
            :code => fault_code
          }))          
        end
      end

      private

        def parse_fault(fault_string)
          fault_string.lines.first.strip
        end

    end
  end
end