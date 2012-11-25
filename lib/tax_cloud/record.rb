module TaxCloud
  # A generic record.
  class Record
    def initialize(attrs = {})
      attrs.each do |sym, val|
        self.send "#{sym}=", val
      end
    end
  end
end
