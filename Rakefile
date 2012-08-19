require 'rubygems'
require 'bundler/setup'
require 'releasy'

Releasy::Project.new do
  name "Sweepr"
  version "1.0"
  verbose

  executable "main.rb"
  files "lib/**/*.rb", "res/**/*"
  exclude_encoding

  add_build :osx_app do
    url "com.eddm.sweepr"
    wrapper "bin/wrappers/gosu-mac-wrapper-0.7.44.tar.gz"
    add_package :tar_gz
  end

  add_deploy :github
end
