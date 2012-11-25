module TaxCloud
  class TaxCode
    class Groups
      
      class << self

        # All Tax Code Groups
        def all
          @tax_code_groups ||= begin
            response = TaxCloud.client.request :get_tic_groups
            tax_code_groups = TaxCloud::Responses::TaxCodeGroups.parse response
            Hash[tax_code_groups.map { |tax_code_group| [ tax_code_group.group_id, tax_code_group ] }]
          end
        end

        # Lookup a tax code group by ID.
        def [](group_id)
          all[group_id]
        end

      end
    end
  end
end
