class Hash
  # Downcase the keys. Use this because <tt>TaxCloud::Address.verify</tt> requires downcased keys
  def downcase_keys!
    keys.each do |key|
      self[key.to_s.downcase] = delete(key)
    end
    self
  end
end
