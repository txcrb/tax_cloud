module TaxCloud
  class Client < Savon::Client

    def initialize(configuration)
      @configuration = configuration
      super TaxCloud::WSDL_URL
    end

    def request(method, body)
      safe do
        super method, :body => body
      end
    end

    private

      def safe &block
        begin
          yield
        rescue Savon::SOAP::Fault => e
          raise TaxCloud::Errors::SoapError.new(e)
        end
      end

      # Authorization hash to use with all SOAP requests
      def auth_params
        {
          'apiLoginID' => @configuration.api_login_id,
          'apiKey' => @configuration.api_key
        }
      end

  end
end
