# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader' if development?
require 'tilt/erubis'

require_relative 'lib/game.rb'

configure do
  enable :sessions
  set :session_secret, development? ? 'secret' : SecureRandom.hex(64)
end

helpers do
  def each_dealer_card_image_path
    @dealer.hand.each_with_index do |card, idx|
      path = if !end_of_game?
               "/images/#{idx.zero? ? 'cards/' + card.to_s : 'back'}.png"
             else
               "/images/cards/#{card}.png"
             end
      yield path
    end
  end

  def each_player_card_image_path
    @player.hand.each do |card|
      yield "/images/cards/#{card}.png"
    end
  end

  def end_of_game?
    @game.game_over
  end
end

before do
  pass if request.path_info == '/'

  @game = session[:game]
  @dealer = @game.dealer
  @player = @game.player
  @player_score = @player.score
  @dealer_score = @dealer.score
  @player_hand_value = @player.total(Game::MAX_LIMIT)
  @dealer_hand_value = @dealer.total(Game::MAX_LIMIT)
end

def initialize_game
  session[:game] = Game.new
end

def handle_end_of_round
  if @gamep.player_bust?
    flash('Oops! You busted! Dealer wins!', :danger)
    @dealer.increment_score
    @game.game_over = true
  elsif @game.dealer_bust?
    flash('Woo! The dealer busted. You win!', :success)
    @player.increment_score
    @game.game_over = true
  else
    case @game.winner
    when :player
      flash("You won! Show that dealer who's boss!", :success)
      @player.increment_score
      @game.game_over = true
    when :dealer
      flash('The dealer won this round. But I believe in you!', :danger)
      @dealer.increment_score
      @game.game_over = true
    when :neither
      flash('It was a tie. Better luck next time!')
      @game.game_over = true
    end
  end
end

def hit
  if end_of_game?
    flash("It's the end of the round. You can't hit anymore!", :danger)
  else
    @game.hit(@player)
    handle_end_of_round if @game.player_bust?
  end
end

def stay
  if end_of_game?
    flash("It's the end of the round. Move on to the next round!", :danger)
  else
    @game.dealer_turn
    handle_end_of_round
  end
end

def next_round
  @game.reset_game
end

def reset
  flash('Game has been reset!', :success)
  @game.total_reset
end

def flash(message, type = :neutral)
  session[:flash] = { message: message, type: type }
end

get '/' do
  flash('Hi there!', :success)
  initialize_game
  erb :index
end

get '/play' do
  erb :play
end

post '/hit' do
  hit
  redirect '/play'
end

post '/stay' do
  stay
  redirect '/play'
end

post '/next_round' do
  next_round
  redirect '/play'
end

get '/reset' do
  flash('You cannot undo this action!', :danger)
  erb :reset
end

post '/reset' do
  reset
  redirect '/play'
end
