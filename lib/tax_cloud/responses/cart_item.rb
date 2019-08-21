require 'bigdecimal'

module TaxCloud #:nodoc:
  module Responses #:nodoc:
    # A single item in the response to a TaxCloud Lookup API call.
    #
    # See https://api.taxcloud.net/1.0/TaxCloud.asmx?op=Lookup.
    class CartItem
      # The index of the cart item.
      attr_accessor :cart_item_index

      # Tax amount for this cart item.
      attr_accessor :tax_amount

      # === Parameters
      # [savon_response] SOAP response.
      def initialize(savon_response)
        self.cart_item_index = savon_response[:cart_item_index].to_i
        self.tax_amount = BigDecimal(savon_response[:tax_amount])
      end
    end
  end
end
