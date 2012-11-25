module TaxCloud
  module Responses

    # A single item in the response to a TaxCloud Lookup.
    # https://api.taxcloud.net/1.0/TaxCloud.asmx?op=Lookup
    class CartItem

      attr_accessor :cart_item_index, :tax_amount

      def initialize(savon_response)
        self.cart_item_index = savon_response[:cart_item_index].to_i
        self.tax_amount = savon_response[:tax_amount].to_f
      end

    end
  end
end