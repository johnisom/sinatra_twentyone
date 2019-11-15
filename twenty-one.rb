# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader' if development?
require 'tilt/erubis'

get '/' do
  erb :index
end

get '/play' do
  erb :play
end
