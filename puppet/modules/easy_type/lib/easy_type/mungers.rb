# encoding: UTF-8
#
#
# Define all common mungers available for all types
#
module EasyType
  #
  # The Integer munger, munges a specified value to an Integer.
  #
  module Mungers
    # @nodoc
    module Integer
      # @private
      def unsafe_munge(value)
        Integer(value)
      end
    end

    #
    # The Integer munger, munges a specified value to an Integer.
    #
    module Size
      # @private
      def unsafe_munge(size)
        return size if size.is_a?(Numeric)
        case size
        when /^\d+(K|k)$/ then size.chop.to_i * 1024
        when /^\d+(M|m)$/ then size.chop.to_i * 1024 * 1024
        when /^\d+(G|g)$/ then size.chop.to_i * 1024 * 1024 * 1024
        when /^\d+$/ then size.to_i
        else
          fail('invalid size')
        end
      end
    end

    #
    # The Upcase munger, munges a specified value to an uppercase String
    #
    module Upcase
      # @private
      def unsafe_munge(string)
        string.upcase
      end
    end

    # @nodoc
    module Downcase
      def unsafe_munge(string)
        string.downcase
      end
    end
  end
end
