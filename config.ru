require 'rubygems'
require 'bundler/setup'
require File.dirname(__FILE__) + 'lib/convertify'

set :views, File.dirname(__FILE__) + '/views'
run Convertify::Application