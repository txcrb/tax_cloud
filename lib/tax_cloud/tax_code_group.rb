module TaxCloud #:nodoc:
  # A group of tax codes.
  #
  # See https://taxcloud.net/tic.
  class TaxCodeGroup < Record
    # Group ID.
    attr_accessor :group_id
    # Group description.
    attr_accessor :description

    # All Tax Codes in this group.
    def tax_codes
      @tax_codes ||= begin
        response = TaxCloud.client.request :get_ti_cs_by_group,  tic_group: group_id
        tax_codes = TaxCloud::Responses::TaxCodesByGroup.parse response
        Hash[tax_codes.map { |tic| [tic.ticid, tic] }]
      end
    end

    # Lookup a tax code by ID.
    #
    # === Parameters
    # [ticid] Tax code ID.
    def [](ticid)
      tax_codes[ticid]
    end
  end
end
