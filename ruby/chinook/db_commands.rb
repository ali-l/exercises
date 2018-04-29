





# ActiveRecord Exercises
#1 => 35
Track.where(genre_id: Genre.where(name: 'Hip Hop/Rap').first.id).count;

#2 All $0.99
MediaType.find_by(name: 'MPEG audio file') #id = 1
Track.where(media_type_id: 1).order(:unit_price => :desc).first

#3
Artist.order(:created_at).first(2)

#4
Playlist.order(:created_at => :desc).first(2)
Playlist.find(4).tracks
Playlist.find(3).tracks