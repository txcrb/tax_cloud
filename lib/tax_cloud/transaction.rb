module TaxCloud #:nodoc:
  # Lookup tax rate, authorize, and capture the information to be logged into TaxCloud.
  #
  # *Note:* The Transaction must not change between the <tt>lookup</tt> and <tt>authorization</tt> method calls.
  class Transaction < Record
    # User-defined customer ID for the <tt>Transaction</tt>.
    attr_accessor :customer_id
    # User-defined cart ID for the order.
    attr_accessor :cart_id
    # Array of <tt>CartItem</tt>s.
    attr_accessor :cart_items
    # The order ID for <tt>authorized</tt>, <tt>captured</tt>, and <tt>authorized_with_captured</tt> methods.
    attr_accessor :order_id
    # The <tt>Address</tt> of which the shipment originates.
    attr_accessor :origin
    # The <tt>Address</tt> of which the shipment arrives.
    attr_accessor :destination

    # Create a new transaction.
    # === Parameters
    # [params] Transaction params.
    def initialize(params = {})
      params = { :cart_items => [] }.merge(params)
      super params
    end

    # Lookup the tax rate for the transaction.
    # The returned information is based on the originating address, destination address, and cart items.
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
        'dateAuthorized' => xml_date(options[:date_authorized])
      }

      response = TaxCloud.client.request :authorized, request_params
      TaxCloud::Responses::Authorized.parse response
    end

    # Complete the transaction. The <tt>order_id</tt> passed into <tt>captured</tt> must match the <tt>order_id</tt> that was passed into <tt>authorized</tt>.
    #
    # === Options
    # [date_captured] The time the transaction was captured. Default is today.
    def captured(options = {})
      options = { :date_captured => Date.today }.merge(options)
      request_params = {
        'customerID' => customer_id,
        'cartID' => cart_id,
        'orderID' => order_id,
        'dateCaptured' => xml_date(options[:date_captured])
      }

      response = TaxCloud.client.request :captured, request_params
      TaxCloud::Responses::Captured.parse response
    end

    # Combines the <tt>authorized</tt> and <tt>captured</tt> methods into a single call
    #
    # === Options
    # [date_authorized] The date the transaction was authorized. Default is today.
    # [date_captured] - The date the transaction was captured. Default is today.
    def authorized_with_capture(options = {})
      options = { :date_authorized => Date.today, :date_captured => Date.today }.merge(options)
      request_params = {
        'customerID' => customer_id,
        'cartID' => cart_id,
        'orderID' => order_id,
        'dateAuthorized' => xml_date(options[:date_authorized]),
        'dateCaptured' => xml_date(options[:date_captured])
      }

      response = TaxCloud.client.request :authorized_with_capture, request_params
      TaxCloud::Responses::AuthorizedWithCapture.parse response
    end

    # Marks any included cart items as returned.
    #
    # === Options
    # [returned_date] The date the return occured. Default is today.
    def returned(options = {})
      options = { :returned_date => Date.today }.merge(options)
      request_params = {
        'orderID' => order_id,
        'cartItems' => { 'CartItem' => cart_items.map(&:to_hash) },
        'returnedDate' => xml_date(options[:returned_date])
      }

      response = TaxCloud.client.request :returned, request_params
      TaxCloud::Responses::Returned.parse response
    end

    private

    def xml_date(val)
      val.respond_to?(:strftime) ? val.strftime("%Y-%m-%d") : val
    end
  end
end
