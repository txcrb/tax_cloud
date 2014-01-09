module TaxCloud #:nodoc:
  class TaxCode
    # A TaxCloud::TaxCode::Group organizes tax codes in a logical group.
    class Groups
      class << self
        # All tax code groups.
        def all
          @tax_code_groups ||= begin
            response = TaxCloud.client.request :get_tic_groups
            tax_code_groups = TaxCloud::Responses::TaxCodeGroups.parse response
            Hash[tax_code_groups.map { |tax_code_group| [tax_code_group.group_id, tax_code_group] }]
          end
        end

        # Lookup a tax code group by ID.
        #
        # === Parameters
        # [group_id] Group ID.
        def [](group_id)
          all[group_id]
        end
      end
    end
  end
end
