module TaxCloud #:nodoc:
  # A generic TaxCloud record.
  class Record
    # Initialize the record.
    #
    # === Parameters
    # [attrs] Attributes defined for this record.
    def initialize(attrs = {})
      attrs.each do |sym, val|
        send "#{sym}=", val
      end
    end
  end
end
