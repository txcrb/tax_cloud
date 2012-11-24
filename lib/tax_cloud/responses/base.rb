module TaxCloud
  module Responses
    class Base
      
      attr_accessor :raw

      class_attribute :dsl

      def initialize(savon_response)
        @raw = savon_response.to_hash
        parse!
      end

      class << self
        def response_type(value)
          self.set_dsl(:response_type, value)
        end

        def error_message(value)
          self.set_dsl(:error_message, value)
        end

        def set_dsl(key, value)
          self.dsl ||= {}
          self.dsl[key] = value
          self.dsl
        end

        def parse(savon_response)
          self.new(savon_response)
        end
      end

      private

        def match(chain)
          current_value = raw
          chain.split("/").each do |key|
            current_value = current_value[key.to_sym]
            next if current_value
            raise TaxCloud::Errors::UnexpectedSoapResponse.new(raw, key, chain)
          end
          current_value
        end

        def parse!
          raise "missing response_type dsl" unless self.dsl[:response_type]
          raise "missing error_message dsl" unless self.dsl[:error_message]
          return true if match(self.dsl[:response_type]) == "OK"
          raise TaxCloud::Errors::ApiError.new(match(self.dsl[:error_message]), raw)
        end

    end
  end
end