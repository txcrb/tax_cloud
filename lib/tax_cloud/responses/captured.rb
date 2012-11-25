module TaxCloud
  module Responses

    # Response to a TaxCloud Captured.
    # https://api.taxcloud.net/1.0/TaxCloud.asmx?op=Captured
    class Captured < Generic
      response_key :captured
    end
  end
end