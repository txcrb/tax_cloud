module TaxCloud #:nodoc:
  # A TIC (Taxability Information Code), otherwise known as a Tax Code.
  # 
  # See https://taxcloud.net/tic.
  class TaxCode < Record
    # Tax code ID.
    attr_accessor :ticid
    # Tax code description.
    attr_accessor :description
  end
end
