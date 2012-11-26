module TaxCloud #:nodoc:
  class TaxCodes

    # General purpose tax code.
    GENERAL = 00000

    class << self

      # All tax codes
      def all
        @tax_codes ||= begin
          response = TaxCloud.client.request :get_ti_cs
          tax_codes = TaxCloud::Responses::TaxCodes.parse response
          Hash[tax_codes.map { |tic| [ tic.ticid, tic ] }]
        end
      end

      # Lookup a tax code by ID.
      #
      # === Parameters
      # [ticid] Tax code ID.
      def [](ticid)
        all[ticid]
      end

    end

  end
end
