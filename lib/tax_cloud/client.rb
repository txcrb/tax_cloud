module TaxCloud
  class Client < Savon::Client

    def initialize
      super TaxCloud::WSDL_URL
    end

    def request(method, body)
      safe do
        super method, :body => body.merge(auth_params)
      end
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
        rescue Savon::SOAP::Fault => e
          raise TaxCloud::Errors::SoapError.new(e)
        end
      end

  end
end
