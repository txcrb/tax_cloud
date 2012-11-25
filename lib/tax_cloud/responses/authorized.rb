module TaxCloud
  module Responses
    # Response to a TaxCloud Authorized.
    # https://api.taxcloud.net/1.0/TaxCloud.asmx?op=Authorized
    class Authorized < Generic
      response_key :authorized
    end
  end
end