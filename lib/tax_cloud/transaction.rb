module TaxCloud
  # Lookup tax rate, authorize, and capture the information to be logged into TaxCloud.
  #
  # *Note:* The Transaction must not change between the <tt>lookup</tt> and <tt>authorization</tt> method calls.
  #
  # === Attributes
  # * <tt>customer_id</tt> - Your defined customer ID for the <tt>Transaction</tt>.
  # * <tt>cart_id</tt> - Your defined cart ID for the order.
  # * <tt>cart_items</tt> - Array of <tt>CartItem</tt>s.
  # * <tt>order_id</tt> - The order ID for <tt>authorized</tt>, <tt>captured</tt>, and <tt>authorzied_with_captured</tt> methods.
  # * <tt>origin</tt> - The <tt>Address</tt> of which the shipment originates.
  # * <tt>destination</tt> - The <tt>Address</tt> of which the shipment arrives.
  class Transaction
    attr_accessor :customer_id, :cart_id, :cart_items, :order_id, :origin, :destination

    # Creates a new <tt>Transaction</tt> object with the given parameters
    def initialize(params = {})
      params = { :cart_items => [] }.merge(params)
      params.each do |key, value|
        self.send "#{key}=", value
      end
    end

    # Lookup the tax rate for the transaction. The returned information is based on the originating address, destination address, and cart items.
    def lookup
      request_params = {
        'customerID' => customer_id,
        'cartID' => cart_id,
        'cartItems' => { 'CartItem' => cart_items.map(&:to_hash) },
        'origin' => origin.to_hash,
        'destination' => destination.to_hash
      }

      response = TaxCloud.client.request :lookup, request_params
      TaxCloud::Responses::Lookup.parse response
    end

    # Once a purchase has been made and payment has been authorized, this method must be called. A matching Lookup call must have been made before this is called.
    #
    # === Options
    # * <tt>date_authorized</tt> - The date the transaction was authorized. Default is today.
    def authorized(options = {})
      options = { :date_authorized => Date.today }.merge(options)
      request_params = {
        'customerID' => customer_id,
        'cartID' => cart_id,
        'orderID' => order_id,
        'dateAuthorized' => options[:date_authorized]
      }

      response = TaxCloud.client.request :authorized, request_params
    end

    # Complete the transaction. The <tt>order_id</tt> passed into <tt>captured</tt> must match the <tt>order_id</tt> that was passed into <tt>authorized</tt>.
    #
    # === Options
    # * <tt>date_captured</tt> - The time the transaction was captured. Default is today.
    def captured(options = {})
      options = { :date_captured => Date.today }.merge(options)
      request_params = {
        'customerID' => customer_id,
        'cartID' => cart_id,
        'orderID' => order_id,
        'dateCaptured' => options[:date_captured]
      }

      response = TaxCloud.client.request :captured, request_params
    end

    # Combines the <tt>authorized</tt> and <tt>captured</tt> methods into a single call
    #
    # === Options
    # * <tt>date_authorized</tt> - The date the transaction was authorized. Default is today.
    # * <tt>date_captured</tt> - The date the transaction was captured. Default is today.
    def authorized_with_capture(options = {})
      options = { :date_authorized => Date.today, :date_captured => Date.today }.merge(options)
      request_params = {
        'customerID' => customer_id,
        'cartID' => cart_id,
        'orderID' => order_id,
        'dateAuthorized' => options[:date_authorized],
        'dateCaptured' => options[:date_captured]
      }

      response = TaxCloud.client.request :authorized_with_capture, request_params
    end

    # Marks any included cart items as returned.
    #
    # === Options
    # * <tt>returned_date</tt> - The date the return occured. Default is today.
    def returned(options = {})
      options = { :returned_date => Date.today }.merge(options)
      request_params = {
        'orderID' => order_id,
        'cartItems' => { 'CartItem' => cart_items.map(&:to_hash) },
        'returnedDate' => options[:returned_date]
      }

      TaxCloud.client.request :returned, request_params
    end
  end
end
