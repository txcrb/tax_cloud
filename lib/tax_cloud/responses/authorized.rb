# frozen_string_literal: true

module TaxCloud #:nodoc:
  module Responses #:nodoc:
    # Response to a TaxCloud Authorized API call.
    #
    # See https://asmx.taxcloud.com/1.0/TaxCloud.asmx?op=Authorized.
    class Authorized < Generic
      response_key :authorized
    end
  end
end
