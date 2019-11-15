# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader' if development?
require 'tilt/erubis'

configure do
  enable :sessions
  set :session_secret, 'secret'
end

def flash(message, type=:neutral)
  session[:flash] = { message: message, type: type }
end

get '/' do
  flash('Hi there!', :success)
  erb :index
end

get '/play' do
  erb :play
end
