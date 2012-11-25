module TaxCloud
  module Responses

    # Response to a TaxCloud getTICsByGroup.
    # https://api.taxcloud.net/1.0/TaxCloud.asmx?op=GetTICsByGroup
    class TaxCodesByGroup < Base

      response_type "get_ti_cs_by_group_response/get_ti_cs_by_group_result/response_type"
      error_message "get_ti_cs_by_group_response/get_ti_cs_by_group_result/messages/response_message/message"

      class << self
        # Parse a TaxCloud response.
        # @return [ Array ] An array of TICs.
        def parse(savon_response)
          response = self.new(savon_response)
          tax_codes = response.match("get_ti_cs_by_group_response/get_ti_cs_by_group_result/ti_cs/tic")
          tax_codes.map do |tax_code|
            TaxCloud::TaxCode.new({ 
              :ticid => tax_code[:ticid].to_i,
              :description => tax_code[:description] 
            })
          end
        end
      end

    end
  end
end