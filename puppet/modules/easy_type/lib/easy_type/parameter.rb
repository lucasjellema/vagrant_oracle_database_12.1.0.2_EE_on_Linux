# encoding: UTF-8
module EasyType
  #
  # This module contains all extensions for the Parameter class used by EasyType
  # To use it, include the following statement in your parameter of property block
  #
  #   include EasyType::Parameter
  #
  #
  module Parameter
    # @private
    def self.included(parent)
      parent.extend(ClassMethods)
    end

    # @private
    module ClassMethods
      #
      # retuns the string needed to modify this specific property of a defined type
      #
      # @example
      #
      #  newproperty(:password) do
      #    on_apply do
      #      "identified by #{resource[:password]}"
      #    end
      #  end
      #
      # @param [Method] block The code to be run on creating or modifying a resource. Although the code
      #                 customary returns just a string that is appended to the command, it can do
      #                 anything that is deemed nesceccary.
      #
      # @see on_create  For information on creating a resource
      # @see on_modify  For information on modifying an existing resource
      #
      def on_apply(&block)
        define_method(:on_apply, &block) if block
      end

      #
      # maps a raw resource to retuns the string needed to modify this specific property of a type
      #
      # @example
      #
      #  newproperty(:password) do
      #    map do
      #     "identified by #{resource[:password]}"
      #    end
      #  end
      #
      # @param [Method] block The code to be run to pick a part of the raw_hash and use it as the value of this parameter
      #                 or property.
      #
      def to_translate_to_resource(&block)
        eigenclass = class << self; self; end
        eigenclass.send(:define_method, :translate_to_resource, &block)
      end
    end
  end
end
