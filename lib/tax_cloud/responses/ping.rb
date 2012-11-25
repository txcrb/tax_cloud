module TaxCloud
  module Responses
    # Response to a TaxCloud ping.
    # https://api.taxcloud.net/1.0/TaxCloud.asmx?op=Ping
    class Ping < Generic
      response_key :ping
    end
  end
end