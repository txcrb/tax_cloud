require 'savon'
require 'i18n'
require 'hash'
require 'active_support/core_ext'

require 'tax_cloud/version'
require 'tax_cloud/errors'
require 'tax_cloud/responses'
require 'tax_cloud/record'
require 'tax_cloud/transaction'
require 'tax_cloud/address'
require 'tax_cloud/cart_item'
require 'tax_cloud/tax_code'
require 'tax_cloud/tax_code_group'
require 'tax_cloud/tax_codes'
require 'tax_cloud/tax_code_constants'
require 'tax_cloud/tax_code_groups'
require 'tax_cloud/tax_code_group_constants'
require 'tax_cloud/configuration'
require 'tax_cloud/client'

I18n.load_path << File.join(File.dirname(__FILE__), "config", "locales", "en.yml")

# TaxCloud is a web service to calculate and track sales tax for your ecommerce platform. Integration is easy to use.
# For information on configuring and using the TaxCloud API, look at the <tt>README</tt> file.
module TaxCloud

  # WSDL location for TaxCloud API.
  WSDL_URL = 'https://api.taxcloud.net/1.0/?wsdl'

  # TaxCloud API version.
  API_VERSION = '1.0'

  class << self

    # TaxCloud gem configuration.
    attr_accessor :configuration

    # Returns true if the gem has been configured.
    def configured?
      !! self.configuration
    end

    # Configure the gem.
    def configure
      self.configuration ||= Configuration.new
      yield configuration
    end

    # Reset the current configuration.
    def reset!
      self.configuration = nil
    end

    # The configured SOAP client to the TaxCloud service.
    def client
      check_configuration!
      @@client ||= TaxCloud::Client.new
    end

    private

      def check_configuration!
        raise TaxCloud::Errors::MissingConfig.new unless self.configuration
        self.configuration.check!
      end

  end

end
