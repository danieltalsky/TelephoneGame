# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'

CSV.foreach("/vagrant/TelephoneGame/db/telephone_directory.csv") do |row|
   Artist.create(name:    row[0],
                 contact: row[1],
                 bio:     row[2],
                 url:     row[3],
                 location:row[4])
end