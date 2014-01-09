module TaxCloud #:nodoc:
  # A <tt>CartItem</tt> defines a single line item for the purchase. Used to calculate the tax amount.
  class CartItem < Record
    # The unique index number for the line item. Must be unique for the scope of the cart.
    attr_accessor :index
    # The stock keeping unit (SKU) number.
    attr_accessor :item_id
    # The taxable information code. See TaxCloud::TaxCodes.
    attr_accessor :tic
    # The price of the item. All prices are USD. Do not include currency symbol.
    attr_accessor :price
    # The total number of items.
    attr_accessor :quantity

    # Convert the object to a usable hash for SOAP requests.
    def to_hash
      {
        'Index' => index,
        'ItemID' => item_id,
        'TIC' => tic,
        'Price' => price,
        'Qty' => quantity
      }
    end
  end
end
