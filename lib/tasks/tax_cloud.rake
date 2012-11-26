require 'tax_cloud'

namespace :tax_cloud do

  desc "Configure TaxCloud."
  task :configure do
    unless TaxCloud.configured?
      TaxCloud.configure do |config|
        config.api_login_id = ENV['TAXCLOUD_API_LOGIN_ID']
        config.api_key = ENV['TAXCLOUD_API_KEY']
        config.usps_username = ENV['TAXCLOUD_USPS_USERNAME']
      end  
      Savon.configure do |config|
        config.log = false
      end
      HTTPI.log = false
    end
  end

end
