module TaxCloud
  module Responses

    # Response to a TaxCloud getTICs.
    # https://api.taxcloud.net/1.0/TaxCloud.asmx?op=GetTICs
    class TaxCodes < Base

      response_type "get_ti_cs_response/get_ti_cs_result/response_type"
      error_message "get_ti_cs_response/get_ti_cs_result/messages/response_message/message"

      class << self
        # Parse a TaxCloud response.
        # @return [ Array ] An array of TICs.
        def parse(savon_response)
          response = self.new(savon_response)
          tax_codes = response.match("get_ti_cs_response/get_ti_cs_result/ti_cs/tic")
          tax_codes.map do |tax_code|
            TaxCloud::TaxCode.new({ 
              :ticid => tax_code[:ticid].to_i,
              :description => tax_code[:description].strip
            })
          end
        end
      end

    end
  end
end