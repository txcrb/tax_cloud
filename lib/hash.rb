# frozen_string_literal: true

class Hash #:nodoc: all
  # Downcase the keys. Use this because <tt>TaxCloud::Address.verify</tt> requires downcased keys
  def downcase_keys
    transform_keys(&:downcase)
  end
end
