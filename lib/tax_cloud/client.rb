module TaxCloud #:nodoc:
  # A <tt>Client</tt> communicates with the TaxCloud service.
  class Client < Savon::Client

    # Create a new client.
    def initialize
      super :wsdl => TaxCloud::WSDL_URL
    end

    # Make a safe SOAP call.
    # Will raise a TaxCloud::Errors::SoapError on error.
    #
    # === Parameters
    # [method] SOAP method.
    # [body] Body content.
    def call(method, message = {})
      safe do
        super method, :message => message.merge(auth_params)
      end
    end

    def request(method, message = {})
      call method, message
    end

    # Ping the TaxCloud service.
    #
    # Returns "OK" or raises an error if the TaxCloud service is unreachable.
    def ping
      TaxCloud::Responses::Ping.parse request(:ping)
    end

    private

      # Authorization hash to use with all SOAP requests
      def auth_params
        {
          'apiLoginID' => TaxCloud.configuration.api_login_id,
          'apiKey' => TaxCloud.configuration.api_key
        }
      end

      def safe &block
        begin
          yield
        rescue Savon::SOAPFault => e
          raise TaxCloud::Errors::SoapError.new(e)
        end
      end

  end
end
