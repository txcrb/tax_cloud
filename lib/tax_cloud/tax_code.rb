module TaxCloud
  # A TIC is a Taxability Information Code.
  # See https://taxcloud.net/tic/
  class TaxCode < Record
    attr_accessor :ticid, :description
  end
end
