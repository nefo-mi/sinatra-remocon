# -*- coding: utf-8 -*-
$: << '.'

require 'sinatra'
require 'haml'
require 'yaml'

require 'lib/remocon'

config_path = File.expand_path(File.dirname(__FILE__) + '/config.yml')
config = YAML.load_file(config_path)

remo = Remocon.new(
  config[:serial_port], 
  config[:serial_baudrate], 
  config[:serial_databit], 
  config[:serial_stopbit], 
  SerialPort::NONE
)

get '/' do
  haml :index
end

get '/pon' do
  remo.turnon
  haml :index
end
