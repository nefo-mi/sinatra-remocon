# -*- coding: utf-8 -*-
$: << '.'

require 'sinatra'
require 'haml'
require 'yaml'

require 'lib/remocon'

configure do
  config_path = File.expand_path(File.dirname(__FILE__) + '/config.yml')
  config = YAML.load_file(config_path)

  $remo = Remocon.new(
    config[:serial_port], 
    config[:serial_baudrate], 
    config[:serial_databit], 
    config[:serial_stopbit], 
    SerialPort::NONE
  )
end

get '/', agent: %r{curl} do
  uri = request.host + (request.port == 80 ? '' : ":#{request.port.to_s}") 
  signals = remo.signals
<<EOL
  curl -d 'signal=signal' #{uri} 
  signals -> #{signals}
EOL
end

get '/' do
  @url = request.host + (request.port == 80 ? '' : ":#{request.port.to_s}")
  @signals = $remo.signals
  haml :index
end

post '/', agent: %r{curl} do
  signal = params[:signal]
  if ( $remo.send_signal( signal ))
    "send " + signal
  else
    signal + " not found"
  end
end

post '/' do
  signal = params[:signal]
  remo.send_signal( signal )
  @url = request.host + (request.port == 80 ? '' : ":#{request.port.to_s}")
  @signals = remo.signals
  haml :index
end
