require 'bundler/setup'
require 'rspotify'
require 'discordrb'

TIME_TO_SHOW = 10
SPOTIFY_TRACK_ID_REGEX = %r{https:\/\/open\.spotify\.com\/track\/(\w*)}
SPOTIFY_CLIENT_ID = ''
SPOTIFY_CLIENT_SECRET = ''
DISCORD_TOKEN = ''

RSpotify.authenticate(SPOTIFY_CLIENT_ID, SPOTIFY_CLIENT_SECRET)

bot = Discordrb::Bot.new token: DISCORD_TOKEN

def joined_artists_string(track)
  track.artists.map(&:name).join(' & ')
end

bot.message(contains: SPOTIFY_TRACK_ID_REGEX) do |event|
  track_id = event.message.content.match(SPOTIFY_TRACK_ID_REGEX)[1]
  track = RSpotify::Track.find(track_id)

  event.send_temp "This is #{track.name}, by #{joined_artists_string(track)}", TIME_TO_SHOW
  event
end

bot.run