# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'open-uri'

localArtist = Artist.create(
  name: "Satellite Collective",
  contact: "Daniel@Satellite-Collective.org",
  bio: "We create accessible and diverse opportunities for artists in the performing and visual arts.",
  url: "http://satellitecollective.org",
  location: "New York, NY USA"
)

localWork = Work.create(
  title: "Breton Fisherman's Prayer",
  orig_id: "0001",
  full_orig_id: "0001-0000",
  medium: "Poem",
  parent_id: nil,
  artist_id: localArtist.id
)

WorkRepresentation.create(
  work_id: localWork.id,
  #url: 'http://telephone.satellitepress.org/workrepresentations/' + URI::encode(filename),
  #fileext: filename.split(".").pop.downcase,
  text_body_markdown: "*'Oh God thy sea is so great and my boat is so small.'*
- Breton Fisherman's Prayer"
)

danielUser = User.create(:email => 'danieltalsky@gmail.com')
danielUser.update_password 'fakePASSWORDSonlyYo'
jonathanUser = User.create(:email => 'jonathan.harford@gmail.com')
jonathanUser.update_password 'fakePASSWORDSonlyYo'
nathanUser = User.create(:email => 'langston.nathan@gmail.com')
nathanUser.update_password 'fakePASSWORDSonlyYo'
kevinUser = User.create(:email => 'kevin@satellite-collective.org')
kevinUser.update_password 'fakePASSWORDSonlyYo'
