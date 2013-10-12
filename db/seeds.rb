# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'
artistsTempCSV = '/vagrant/TelephoneGame/db/telephone_directory.csv'
if (File.exists?(artistsTempCSV))
    CSV.foreach(artistsTempCSV) do |row|
       Artist.create(name:    row[0],
                     contact: row[1],
                     bio:     row[2],
                     url:     row[3],
                     location:row[4])
    end
end

danielUser = User.create(:email => 'danieltalsky@gmail.com')
danielUser.update_password 'fakePASSWORDSonlyYo'
jonathanUser = User.create(:email => 'jonathan.harford@gmail.com')
jonathanUser.update_password 'fakePASSWORDSonlyYo'
nathanUser = User.create(:email => 'langston.nathan@gmail.com')
nathanUser.update_password 'fakePASSWORDSonlyYo'
kevinUser = User.create(:email => 'kevin@satellite-collective.org')
kevinUser.update_password 'fakePASSWORDSonlyYo'