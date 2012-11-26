module TaxCloud #:nodoc:
  module Responses #:nodoc:
    # Response to a TaxCloud Ping API call.
    # 
    # See https://api.taxcloud.net/1.0/TaxCloud.asmx?op=Ping.
    class Ping < Generic
      response_key :ping
    end
  end
end