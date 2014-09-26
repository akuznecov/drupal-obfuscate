#!/usr/bin/env ruby

require "rubygems"
require 'bundler/setup'
require "my_obfuscate"

USERS_PASSWORD = "$S$DTgyuWv/vHqi.Z/MUiQrdHmcnB1rp9Ss7YsU9FoMpcmhXjn4503q"


def ingore_users
  lambda do |person|
    person[:uid] == "0" || person[:uid] == "1"
  end
end


obfuscator = MyObfuscate.new({
  :users => {
    :pass  => { :type => :fixed,
                :string => "#{USERS_PASSWORD}",
                :unless => ingore_users,
              },
    :mail  => { :type => :email,
                :unless => ingore_users,
              },
    :init  => { :type => :email,
                :unless => ingore_users,
              },
  },

  :cache            => :truncate,
  :cache_block      => :truncate,
  :cache_bootstrap  => :truncate,
  :cache_field      => :truncate,
  :cache_filter     => :truncate,
  :cache_form       => :truncate,
  :cache_image      => :truncate,
  :cache_menu       => :truncate,
  :cache_page       => :truncate,
  :cache_path       => :truncate,

  :sessions         => :truncate,
  :watchdog         => :truncate,
})

#obfuscator.fail_on_unspecified_columns = false
#obfuscator.globally_kept_columns = %w[id created_at updated_at]
obfuscator.ignore_depricated_warnings = true
obfuscator.obfuscate(STDIN, STDOUT)
