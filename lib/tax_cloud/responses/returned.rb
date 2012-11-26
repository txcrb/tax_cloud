module TaxCloud #:nodoc:
  module Responses #:nodoc:
    # Response to a TaxCloud Returned API call.
    # 
    # See https://api.taxcloud.net/1.0/TaxCloud.asmx?op=Returned.
    class Returned < Generic
      response_key :returned
    end
  end
end