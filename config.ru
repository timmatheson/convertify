require 'rubygems'
require 'bundler/setup'
$:.push(File.expand_path(File.dirname(__FILE__)))
require 'lib/convertify'

set :views, File.dirname(__FILE__) + '/views'
run Convertify::Application