module TaxCloud
  module Responses
    # Response to a TaxCloud AuthorizedWithCapture.
    # https://api.taxcloud.net/1.0/TaxCloud.asmx?op=AuthorizedWithCapture
    class AuthorizedWithCapture < Generic
      response_key :authorized_with_capture
    end
  end
end