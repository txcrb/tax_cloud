# encoding: utf-8
# generously borrowed from https://github.com/mongoid/mongoid/blob/master/lib/mongoid/errors/mongoid_error.rb
module TaxCloud
  module Errors

    # Default parent TaxCloud error for all custom errors. This handles the base
    # key for the translations and provides the convenience method for
    # translating the messages.
    class TaxCloudError < StandardError

      attr_reader :problem, :summary, :resolution

      BASE_KEY = "taxcloud.errors.messages"

      # Compose the message.
      # @param [ String ] key Lookup key in the translation table.
      # @param [ Hash ] attributes The objects to pass to create the message.
      def compose_message(key, attributes = {})
        @problem = create_problem(key, attributes)
        @summary = create_summary(key, attributes)
        @resolution = create_resolution(key, attributes)

        "\nProblem:\n  #{@problem}"+
        "\nSummary:\n  #{@summary}"+
        "\nResolution:\n  #{@resolution}"
      end

      private

      # Given the key of the specific error and the options hash, translate the
      # message.
      #
      # @example Translate the message.
      #   error.translate("errors", :key => value)
      #
      # @param [ String ] key The key of the error in the locales.
      # @param [ Hash ] options The objects to pass to create the message.
      #
      # @return [ String ] A localized error message string.
      def translate(key, options)
        ::I18n.translate("#{BASE_KEY}.#{key}", { locale: :en }.merge(options)).strip
      end

      # Create the problem.
      #
      # @example Create the problem.
      #   error.create_problem("error", {})
      #
      # @param [ String, Symbol ] key The error key.
      # @param [ Hash ] attributes The attributes to interpolate.
      #
      # @return [ String ] The problem.
      #
      # @since 1.0.0
      def create_problem(key, attributes)
        translate("#{key}.message", attributes)
      end

      # Create the summary.
      #
      # @example Create the summary.
      #   error.create_summary("error", {})
      #
      # @param [ String, Symbol ] key The error key.
      # @param [ Hash ] attributes The attributes to interpolate.
      #
      # @return [ String ] The summary.
      #
      # @since 1.0.0
      def create_summary(key, attributes)
        translate("#{key}.summary", attributes)
      end

      # Create the resolution.
      #
      # @example Create the resolution.
      #   error.create_resolution("error", {})
      #
      # @param [ String, Symbol ] key The error key.
      # @param [ Hash ] attributes The attributes to interpolate.
      #
      # @return [ String ] The resolution.
      #
      # @since 1.0.0
      def create_resolution(key, attributes)
        translate("#{key}.resolution", attributes)
      end
    end
  end
end