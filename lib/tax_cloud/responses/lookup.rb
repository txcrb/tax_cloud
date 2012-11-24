module TaxCloud
  module Responses

    # Response to a TaxCloud Lookup.
    # https://api.taxcloud.net/1.0/TaxCloud.asmx?op=Lookup
    class Lookup < Base

      attr_accessor :cart_id, :cart_items

      response_type "lookup_response/lookup_result/response_type"

      def initialize(savon_response)
        super savon_response
        self.cart_id = match("lookup_response/lookup_result/cart_id")
        # there can be on response or an array of responses
        cart_item_responses = match("lookup_response/lookup_result/cart_items_response/cart_item_response")
        if cart_item_responses.is_a?(Array)
          self.cart_items = cart_item_responses.map do |cart_item_response|
            TaxCloud::Responses::CartItem.new(cart_item_response)
          end
        else
          self.cart_items = [ TaxCloud::Responses::CartItem.new(cart_item_responses) ]
        end
      end

      def tax_amount
        cart_items.inject(0) { |acc, item| acc + item.tax_amount }
      end

    end
  end
end