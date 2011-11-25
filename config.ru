require 'rubygems'
require 'bundler/setup'
require './lib/convertify'

set :views, File.dirname(__FILE__) + '/views'
run Convertify::Application