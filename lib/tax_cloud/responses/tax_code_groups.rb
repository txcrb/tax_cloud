module TaxCloud
  module Responses

    # Response to a TaxCloud getTICGroups.
    # https://api.taxcloud.net/1.0/TaxCloud.asmx?op=GetTICGroups
    class TaxCodeGroups < Base

      response_type "get_tic_groups_response/get_tic_groups_result/response_type"
      error_message "get_tic_groups_response/get_tic_groups_result/messages/response_message/message"

      class << self
        # Parse a TaxCloud response.
        # @return [ Array ] An array of Tax Code Groups.
        def parse(savon_response)
          response = self.new(savon_response)
          tax_code_groups = response.match("get_tic_groups_response/get_tic_groups_result/tic_groups/tic_group")
          tax_code_groups.map do |tax_code_group|
            TaxCloud::TaxCodeGroup.new({ 
              :group_id => tax_code_group[:group_id].to_i,
              :description => tax_code_group[:description] 
            })
          end
        end
      end

    end
  end
end