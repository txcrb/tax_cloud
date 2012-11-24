module TaxCloud
  module Responses

    # Response to a TaxCloud ping.
    # https://api.taxcloud.net/1.0/TaxCloud.asmx?op=Ping
    class Ping < Base

      response_type "ping_response/ping_result/response_type"
      error_message "ping_response/ping_result/messages/response_message/message"

      class << self
        # Parse a TaxCloud response.
        # @return [ String ] "OK"
        def parse(savon_response)
          response = self.new(savon_response)
          response.raw[:ping_response][:ping_result][:response_type]
        end
      end

    end

  end
end