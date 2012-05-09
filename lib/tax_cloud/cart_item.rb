require 'builder'

module TaxCloud
  # A <tt>CartItem</tt> defines a single line item for the purchase. Used to calculate the tax amount.
  #
  # === Attributes
  # * <tt>index</tt> - The unique index number for the line item. Must be unique for the scope of the cart.
  # * <tt>item_id</tt> - The stock keeping unit (SKU) number
  # * <tt>tic</tt> - The taxable information code. See <tt>TaxCloud::TaxCodes</tt>.
  # * <tt>price</tt> - The price of the item. All prices are USD. Do not include currency symbol.
  # * <tt>quantity</tt> - The total number of items.
  class CartItem
    attr_accessor :index, :item_id, :tic, :price, :quantity

    def initialize(attrs = {})
      attrs.each do |sym, val|
        self.send "#{sym}=", val
      end
    end

    # Convert the object to a usable hash for SOAP requests
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
