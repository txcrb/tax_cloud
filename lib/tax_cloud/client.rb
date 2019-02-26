module TaxCloud #:nodoc:
  # A <tt>Client</tt> communicates with the TaxCloud service.
  class Client < Savon::Client
    # Create a new client.
    def initialize
      super TaxCloud::WSDL_URL

      if client_params.key?(:read_timeout)
        http.read_timeout = client_params[:read_timeout]
      end

      if client_params.key?(:open_timeout)
        http.open_timeout = client_params[:open_timeout]
      end
    end

    # Make a safe SOAP call.
    # Will raise a TaxCloud::Errors::SoapError on error.
    #
    # === Parameters
    # [method] SOAP method.
    # [body] Body content.
    def request(method, body = {})
      safe do
        super method, :body => body.merge(auth_params)
      end
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
      return {} unless TaxCloud.configuration
      {
        'apiLoginID' => TaxCloud.configuration.api_login_id,
        'apiKey' => TaxCloud.configuration.api_key
      }
    end

    def client_params
      { wsdl: TaxCloud::WSDL_URL }.tap do |params|
        params[:open_timeout] = TaxCloud.configuration.open_timeout if TaxCloud.configuration.open_timeout
        params[:read_timeout] = TaxCloud.configuration.read_timeout if TaxCloud.configuration.read_timeout
      end
    end

    def safe
      yield
    rescue Savon::SOAP::Fault => e
      raise TaxCloud::Errors::SoapError.new(e)
    end
  end
end
