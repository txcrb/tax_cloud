class Hash #:nodoc: all
  # Downcase the keys. Use this because <tt>TaxCloud::Address.verify</tt> requires downcased keys
  def downcase_keys
    each_with_object({}) do |(k, v), h|
      h[k.downcase] = v
    end
  end
end
