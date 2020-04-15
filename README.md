# Twenty One #

[Twenty One/Blackjack][blackjack-wiki] powered by Ruby and the
[Sinatra][sinatra-site] framework. You play as the participant and the
computer plays as the dealer. It is hosted live on Heroku at [this
link][herokuapp].

I built this from scratch, with the exception of the Sinatra framework. Keep
in mind that this app is entirely server-based, so there is no JavaScript or
event handling.

## Example Usage ##

<p align="center">
  <img alt="Screencast of app" src="example.gif">
</p>

## Installation ##

1. Clone this repository (`git clone https://github.com/johnisom/sinatra_twentyone`)
2. `cd` into this repository (`cd sinatra_twentyone`)
3. Install dependencies (`bundle install`)
   - If you don’t have ruby-2.6.5, install it
4. Run the server locally (`bundle exec rackup`)
5. Enjoy playing Twenty-One at http://localhost:9292/

[blackjack-wiki]: https://en.wikipedia.org/wiki/Blackjack
[sinatra-site]: http://sinatrarb.com/
[herokuapp]: https://just-a-twenty-one-app.herokuapp.com/
