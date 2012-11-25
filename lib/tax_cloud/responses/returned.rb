module TaxCloud
  module Responses
    # Response to a TaxCloud Returned.
    # https://api.taxcloud.net/1.0/TaxCloud.asmx?op=Returned
    class Returned < Generic
      response_key :returned
    end
  end
end