# frozen_string_literal: true

module TaxCloud #:nodoc:
  module Responses #:nodoc:
    # Response to a TaxCloud AuthorizedWithCapture API call.
    #
    # See https://asmx.taxcloud.com/1.0/TaxCloud.asmx?op=AuthorizedWithCapture.
    class AuthorizedWithCapture < Generic
      response_key :authorized_with_capture
    end
  end
end
