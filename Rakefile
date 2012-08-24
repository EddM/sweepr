require 'rubygems'
require 'bundler/setup'
require 'releasy'

Releasy::Project.new do
  name "Sweepr"
  version "1.0"
  verbose

  executable "run.rb"
  files ["run.rb", "lib/**/*.rb", "res/**/*.wav", "res/**/*.png"]
  exclude_encoding

  add_build :osx_app do
    url "com.eddm.sweepr"
    wrapper "bin/wrappers/gosu-mac-wrapper-0.7.44.tar.gz"
    add_package :tar_gz
    icon "res/icon.icns"
  end
  
  add_build :windows_standalone do
    #icon "res/icon.ico"  # Optional
    exclude_encoding
    add_package :zip
  end
end
