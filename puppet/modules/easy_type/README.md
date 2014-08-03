[![Code Climate](https://codeclimate.com/github/hajee/easy_type.png)](https://codeclimate.com/github/hajee/easy_type) [![Build Status](https://travis-ci.org/hajee/easy_type.png)](https://travis-ci.org/hajee/easy_type) [![Dependency Status](https://gemnasium.com/hajee/easy_type.png)](https://gemnasium.com/hajee/easy_type) [![Coverage Status](https://coveralls.io/repos/hajee/easy_type/badge.png)](https://coveralls.io/r/hajee/easy_type) [![Inline docs](http://inch-ci.org/github/hajee/easy_type.png)](http://inch-ci.org/github/hajee/easy_type)

#easy_type

Robert scratched his head. How would he get a Puppet class to manage a complex resource on his systems? I guess I’ll have to make a Custom Type, he thought. But last time I looked into that, I noticed you need to know a lot about Puppet Internals. 

If you recognize this thought process, easy_type is for you. Like the name says, easy type is designed to make it easy to build a Custom Puppet Type. 

##Tutorial
Check [this blog post](http://hajee.github.io/2014/01/26/puppet-custom-types-the-easy-way/) for a tutorial on using `easy_type`.

##Documentation
Check the [rdoc](http://rubydoc.info/github/hajee/easy_type/master/frames) documentation for easy_type

##Get Started
To get started, you first need to include `easy_type` in your `Puppetfile` or otherwise get it into your puppet directories. To add it to your `Puppetfile`, you can add the following line:

```ruby
mod "hajee/easy_type", “0.x.0”
```

Change the x to the version you would like. You can also use the latest from git.

```ruby
mod  easy_type, :git => "git@github.com:hajee/easy_type.git"
```

After that run the librarian to add the right modules to your puppet tree:

```sh
librarian-puppet install
```

#Creating your type

To create your custom type you will have to create the right directory structure. Go to your module directory and create the next directories:

```bash
mkdir -p module_name/lib
``` 

To create a good starting point for defining your type, copy the scaffold

```sh
cp -Rv easy_type/scaffold module_name/lib/puppet
```

Start editing the example_type.rb file

Here is it's content:
```ruby
require 'easy_type'

module Puppet
  newtype(:example_type) do
    include EasyType

    ensurable
    #
    # Use set_command to set the base command given on creating, destroying and modifying 
    # the resource. This can either be an existing class method on the example_type, or if 
    # a method doesn't exist, it will translate to an os command given.
    # 
    # Example: 
    #   def self.an_existing_class_method(commmand_string)
    #     # DO some important stuff
    #   end
    #
    # set_command(:an_existing_class_method)
    # 
    #
    set_command(:just_a_method)



    to_get_raw_resources do
      #
      # to_get_raw_resources
      # =====================
      # Fill in the code needed to get an array of resources. The array must contain Hashes
      # the Hash can have arbitrary elements. The Hash will be 'picked' by the `to_translate_to_resource`.
      # See the definition of `to_translate_to_resource` in either the parameter or property definition.
      #
      # Although technically not necessary, it is logical to use the defined command. (See set_command)
      #
      # Example:
      #
      # to_get_raw_resources do
      #   packages_string = rpm('-qa','--qf','%{NAME}, %{VERSION}-%{RELEASE}\n')
      #   convert_csv_data_to_hash(packages_string,[:name, :version])
      # end
      #
      # The convert_csv_data_to_hash, is a helper. Like the name says, it converts a comma separated string 
      # to a Hash, The second argument is an Array that contains the elements of the hash. If your string 
      # a header as the first line, you can pass nil for the header Array.
      #
    end

    on_create do
      #
      # on_create
      # =========
      # When Puppet signals it needs to create the resource, it will call this method. The return value of 
      # this method is appended to the command given in set_command
      #
      # Example:
      # --------
      # 
      # do_command(:sql)
      #
      # on_create do
      #    "create user #{self[:name]}"
      # end
      #
      # Explanation:
      # ------------
      # When Puppet needs to create the resource, the sql method is called with parameter "create user username"
      # The `on_create` method will be called in the context of a `provider`. This means you can reference the current
      # resource through `self`.
      # 
      # Property information
      # ------------------------------
      # If you have defined an `on_apply` method in any property or parameter, it's return value will be 
      # appended to the base `on_create` command. See the description of `on_apply` at the type or the property
      #
      #
    end

    on_modify do
      #
      # on_modify
      # =========
      # When Puppet signals it needs to modify the resource, it will call this method. The return value of 
      # this method is appended to the command given in set_command
      #
      # Example:
      # --------
      # 
      # do_command(:sql)
      #
      # on_modify do
      #    "alter user #{self[:name]}"
      # end
      #
      # Explanation
      # ------------
      # When Puppet needs to modify the resource, the sql method is called with parameter "alter user username"
      # The `on_modify` method will be called in the context of a `provider`. This means you can reference the current
      # resource through `self`.
      #
      # Property information
      # ---------------------
      # If you have defined an `on_apply` method in any property or parameter, it's return value will be 
      # appended to the base `on_modify` command. See the description of `on_apply` at the type or the property
      #
      #
    end

    on_destroy do
      #
      # on_destroy
      # ==========
      # When Puppet signals it needs to destroy the resource, it will call this method. The return value of 
      # this method is appended to the command given in set_command
      #
      # Example:
      # --------
      # 
      # do_command(:sql)
      #
      # on_destroy do
      #    "drop user #{self[:name]}"
      # end
      #
      # Explanation
      # -----------
      # When Puppet needs to destroy the resource, the sql method is called with parameter "drop user username"
      # The `on_dstroy` method will be called in the context of a `provider`. This means you can reference the current
      # resource through `self`.
      #
      # Property information
      # --------------------
      # in contrast to `on_create` and `on_modify`, no `on_apply` methods are called on any of the types
      #
      #
    end

    newparam(:name) do
      include EasyType
      #
      # newparam
      # ==========
      # To define a parameter, use the regular newparam(:parameter_name). 
      #
      # Mungers
      # =======
      # If your parameter needs munging, you can include the necessary mungers. Check the documentation 
      # of the Mungers to see which mungers are available
      #
      # Example:
      # --------
      #
      # include EasyType::Mungers::Upcase   # Check easy_type/validators for available mungers
      # 
      # Explanation
      # -----------
      # This will include the Upcase munger. This will change any input in the Puppet Manifest
      # to an Uppercase value before comparing it with the actual value.
      #
      # Validators
      # ==========
      # If your parameter needs validation, you can include the necessary validator. Check the documentation 
      # of the Validators to see which validators are available
      #
      # Example:
      # --------
      #
      # include EasyType::Validators::Name  # Check easy_type/validators for available validators
      # 
      # Explanation
      # -----------
      # This will check if the content of the parameter is a valid name.


      desc "Give you desciption of the parameter"

      isnamevar

      to_translate_to_resource do | raw_resource|
        #raw_resource.column_data('FILL_YOUR_PARAMETER_KEY_HERE')
      end

      #
      # to_translate_to_resource
      # ========================
      # Use this method to pick a part for the raw_resource hash. and translate it to the real resource hash
      # If you have used the `convert_csv_data_to_hash` method to create the Hash, you can use the 
      # `column_data` method to pick the right element from the Hash. `column_data` will show an error 
      # when the data is not available in the Hash.
      #
      # Example:
      # --------
      #
      # to_translate_to_resource do | raw_resource|
      #   raw_resource.column_data('USERNAME').upcase
      # end
      #
      # Explanation:
      # ------------
      #
      # This will extract the `USERNAME` from the `raw_resource` Hash and translate it to an uppercase 
      # value. let's say, the Hash contains {'USERNAME` => 'micky_mouse`}. This would lead to the 
      # following Puppet Resource
      #
      # example_type{micky_mouse: ensure => present,}
      #
      # Tricky stuff
      # ------------
      # Check what the keys of the Hash are. There **is** a difference between 'key', 'KEY', :KEY and :key 
      #
    end


    #
    # parameter
    # ==========
    # You can also use a shortcut:
    #
    # Example:
    # --------
    #   parameter :parameter_name
    #
    # Explanation
    # -----------
    # In this case, easy_type looks for a file 
    # `module_name\lib\puppet\type\type_name\parameter_name.rb`
    # This file *MUST* contain the full parameter definition
    #
    parameter :just_an_other_parameter

    newproperty(:your_property) do
      include EasyType
      #
      # newproperty
      # ==========
      # To define a property, use the regular newproperty(:property_name). 
      #
      #
      # Mungers
      # =======
      # If your property needs munging, you can include the necessary mungers. Check the documentation 
      # of the Mungers to see which mungers are available
      #
      # Example:
      # --------
      #
      # include EasyType::Mungers::Upcase   # Check easy_type/validators for available mungers
      # 
      # Explanation
      # -----------
      # This will include the Upcase munger. This will change any input in the Puppet Manifest
      # to an Uppercase value before comparing it with the actual value.
      #
      # Validators
      # ==========
      # If your property needs validation, you can include the necessary validator. Check the documentation 
      # of the Validators to see which validators are available
      #
      # Example:
      # --------
      #
      # include EasyType::Validators::Name  # Check easy_type/validators for available validators
      # 
      # Explanation
      # -----------
      # This will check if the content of the property is a valid name.

      desc "Give your desciption of the property"

      #
      # to_translate_to_resource
      # ========================
      # Use this method to pick a part for the raw_resource hash. and translate it to the real resource hash
      # If you have used the `convert_csv_data_to_hash` method to create the Hash, you can use the 
      # `column_data` method to pick the right element from the Hash. `column_data` will show an error 
      # when the data is not available in the Hash.
      #
      # Example:
      # --------
      #
      # to_translate_to_resource do | raw_resource|
      #   raw_resource.column_data('USERNAME').upcase
      # end
      #
      # Explanation:
      # ------------
      #
      # This will extract the `USERNAME` from the `raw_resource` Hash and translate it to an uppercase 
      # value. let's say, the Hash contains {'USERNAME` => 'micky_mouse`}. This would lead to the 
      # follwoing Puppet Resource
      #
      # example_type{micky_mouse: ensure => present,}
      #
      # Tricky stuff
      # ------------
      # Check what the keys of the Hash are. There **is** a difference between 'key', 'KEY', :KEY and :key 
      #
      to_translate_to_resource do | raw_resource|
        #raw_resource.column_data('FILL_YOUR_PROPERTY_KEY_HERE')
      end


      #
      # on_apply
      # ========
      # When Puppet signals it needs to create or modify the resource, it will call this method for every modified
      # property. It will then append the return value to the existing string from ether `on_create` or `on_modify`
      #
      # Example:
      # --------
      # in the type
      # 
      #  on_command(:data_source)
      #
      #  on_modify do
      #    "alter #{self[:name]}"
      #  end
      #    
      # 
      #  in the property
      #
      #  on_apply do | command_builder |
      #    "set destination #{resource[:destination]} "
      #  end
      #
      # Explanation
      # ------------
      # When Puppet needs to modify the resource, the `data_source` method is called with parameter "alter my_name"
      # The `on_apply` method will append the text "set destination /dev/null" to the string.
      #
      # While the `on_create`, `on_destroy` and `on_modify` methods are called in the context of the
      # provider, the `on_apply` method is called in the context of the property.
      #
      on_apply do
        "add_your_on_apply_information_for_this_property"
      end

    end

    property :just_an_other_property
    # property
    # ==========
    # You can also use a shortcut:
    #
    # Example:
    # --------
    #   property :property_name
    #
    # Explanation
    # -----------
    # In this case, easy_type looks for a file 
    # `module_name\lib\puppet\type\type_name\property_name.rb`
    # This file *MUST* contain the full property definition
    #

    group(:group_name) do
      # property :first_in_group
      # property :second_in_group
    end
    #
    # group
    # =====
    #
    # Sometimes to get your modify statement correct for a resource, you need to include more parts
    # of the resource. If you define a group of properties, you tell easy_type. To always include all
    # properties in the group if any of them is changed.
    #
    # Example:
    # --------
    # group(:group_name) do
    #   property :first_in_group
    #   property :second_in_group
    # end
    #
    # Explanation:
    # ------------
    # if Puppet signals property `first_in_group` is modified, the command will include the return values of 
    # the `on_apply` for both properties. 
    #
    # Tricky stuff
    # ------------
    # When you want to use a group, you **CANNOT** use inline (e.g. newproperty do), but you **MUST** 
    # use the property definition in the fiCheck what the keys of the Hash are. There **is** a difference between 'key', 'KEY', :KEY and :key 
    #
    #
  end
end

```

Spread the word
---------------
If you like easy_type, You can spread the word by adding a badge to the README.md file of your newly created type.

```
[![Powered By EasyType](https://raw.github.com/hajee/easy_type/master/powered_by_easy_type.png)](https://github.com/hajee/easy_type)
```

This will look like this:

[![Powered By EasyType](https://raw.github.com/hajee/easy_type/master/powered_by_easy_type.png)](https://github.com/hajee/easy_type)


License
-------

MIT License


Contact
-------
Bert Hajee hajee@moretIA.com

Support
-------
Please log tickets and issues at our [Projects site](https://github.com/hajee/easy_type)


[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/hajee/easy_type/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

