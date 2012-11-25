module TaxCloud
  # A group of Taxability Information Codes.
  # See https://taxcloud.net/tic/
  class TaxCodeGroup < Record
    attr_accessor :group_id, :description

    # All Tax Codes in this group.
    def tax_codes
      @tax_codes ||= begin
        response = TaxCloud.client.request :get_ti_cs_by_group, { :tic_group => group_id }
        tax_codes = TaxCloud::Responses::TaxCodesByGroup.parse response
        Hash[tax_codes.map { |tic| [ tic.ticid, tic ] }]
      end
    end

    # Lookup a tax code by ID.
    def [](ticid)
      tax_codes[ticid]
    end

  end
end
