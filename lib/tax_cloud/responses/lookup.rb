# frozen_string_literal: true

module TaxCloud #:nodoc:
  module Responses #:nodoc:
    # Response to a TaxCloud Lookup API call.
    #
    # See https://api.taxcloud.com/1.0/TaxCloud.asmx?op=Lookup.
    class Lookup < Base
      # Cart ID.
      attr_accessor :cart_id

      # Cart items.
      attr_accessor :cart_items

      response_type 'lookup_response/lookup_result/response_type'
      error_message 'lookup_response/lookup_result/messages/response_message/message'

      # === Parameters
      # [savon_response] SOAP response.
      def initialize(savon_response)
        super savon_response
        self.cart_id = match('lookup_response/lookup_result/cart_id')
        # there can be on response or an array of responses
        cart_item_responses = match('lookup_response/lookup_result/cart_items_response/cart_item_response')
        self.cart_items = if cart_item_responses.is_a?(Array)
                            cart_item_responses.map do |cart_item_response|
                              TaxCloud::Responses::CartItem.new(cart_item_response)
                            end
                          else
                            [TaxCloud::Responses::CartItem.new(cart_item_responses)]
                          end
      end

      # Total tax amount in this cart.
      def tax_amount
        cart_items.reduce(0) { |a, e| a + e.tax_amount }
      end
    end
  end
end
