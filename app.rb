# -*- coding: utf-8 -*-
$: << '.'

require 'sinatra'
require 'haml'

require 'lib/remocon'

remo = Remocon.new

get '/' do
  haml :index
end

get '/pon' do
  remo.turnon
  haml :index
end
