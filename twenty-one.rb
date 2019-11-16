# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader' if development?
require 'tilt/erubis'

require_relative 'lib/game.rb'

configure do
  enable :sessions
  set :session_secret, 'secret'
end

helpers do
  def each_dealer_card
  end

  def each_player_card
  end
end

before '/play' do
end

def flash(message, type=:neutral)
  session[:flash] = { message: message, type: type }
end

get '/' do
  flash('Hi there!', :success)
  session[:game] = Game.new
  erb :index
end

get '/play' do
  erb :play
end
