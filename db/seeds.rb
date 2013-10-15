# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'
require 'open-uri'

artistsTempCSV = '/vagrant/TelephoneGame/db/Telephone_Directory.csv'

workRepsPath = '/vagrant/workrepresentations/'
if (File.directory?(workRepsPath))
    fileList = Dir.glob(workRepsPath + '*').select 
end

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

if (File.exists?(artistsTempCSV))
    CSV.foreach(artistsTempCSV) do |row|
       localartist = Artist.create(name:    (row[0].nil? ? "":row[0]) + " " + (row[1].nil? ? "":row[1]),
                                   contact: (row[10].nil? ? "":row[10]),
                                   bio:     (row[9].nil? ? "":row[9]), # We don't actually have a bio field
                                   url:     (row[11].nil? ? "":row[11]),
                                   location:(row[7].nil? ? "":row[7]) + " " + (row[6].nil? ? "":row[6]) + " " + (row[5].nil? ? "":row[5]))
                   
       parentWork = Work.find_by_orig_id(row[4].nil? ? nil : row[4].rjust(4, '0'))
                   
       localWork = Work.create(title:         (row[9].nil? ? "":row[9]) + " by " + (row[0].nil? ? "":row[0]) + " " + (row[1].nil? ? "":row[1]), # We don't actually have a title field
                   orig_id:        (row[3].nil? ? nil : row[3].rjust(4, '0')),
                   orig_parent_id: (row[4].nil? ? nil : row[4].rjust(4, '0')),
                   full_orig_id:   (row[3].nil? ? "" : row[3].rjust(4, '0')) + "_" + (row[4].nil? ? "" : row[4].rjust(4, '0')),
                   medium:         (row[9].nil? ? "":row[9]),
                   parent_id:      (parentWork.nil? ? nil : parentWork.id),
                   artist_id:      localartist.id)
    
        if (!fileList.nil?)
            fileList.each do |f| 
                filename = File.basename(f)
                if filename.start_with?(localWork.full_orig_id)
                    WorkRepresentation.create(
                        work_id: localWork.id,
                        url: 'http://telephone.satellitepress.org/workrepresentations/' + URI::encode(filename),
                        fileext: filename.split(".").pop.downcase
                    )
                end
            end
        end
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
