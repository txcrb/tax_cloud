# frozen_string_literal: true

module TaxCloud # :nodoc:
  module Errors # :nodoc:
    # This error is raised when looking up a transaction without cart items.
    class MissingCartItems < TaxCloudError
      # Create a new error.
      def initialize
        super(compose_message('missing_cart_items'))
      end
    end
  end
end
