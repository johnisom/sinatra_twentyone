# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader' if development?
require 'tilt/erubis'

configure do
  enable :sessions
  set :session_secret, 'secret'
end

helpers do
  def each_dealer_card
    [%w[5 S], %w[J H], %w[A C], %w[2 D], %w[K H]].each do |value, suite|
      yield value, suite
    end
  end

  def each_player_card
    [%w[5 S], %w[J H], %w[A C], %w[2 D], %w[K H], %w[K S]].each do |value, suite|
      yield value, suite
    end
  end
end

before '/play' do
  @computer_hand_value = 21
  @human_hand_value = 21
  @computer_score = 3
  @human_score = 13
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
