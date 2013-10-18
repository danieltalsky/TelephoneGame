require 'csv'
require 'open-uri'


class DataController < ApplicationController
  def seed
	work_representations = open("http://dl.dropboxusercontent.com/u/418477/reps.txt").lines
	dir_str = open("http://dl.dropboxusercontent.com/u/418477/Telephone_Directory.csv").read
    CSV.parse(dir_str) do |row|
		puts row[0]
		puts row[1]
		puts row[2]
		puts row[3]
       localartist = Artist.create(name:    (row[0].nil? ? "":row[0]) + " " + (row[1].nil? ? "":row[1]),
	                               contact: (row[10].nil? ? "":row[10]),
	                               bio:     (row[9].nil? ? "":row[9]), # We don't actually have a bio field
	                               url:     (row[11].nil? ? "":row[11]),
	                               location:(row[7].nil? ? "":row[7]) + " " + (row[6].nil? ? "":row[6]) + " " + (row[5].nil? ? "":row[5]))

	   parentWork = Work.find_by_orig_id(row[4].nil? ? nil : row[4].rjust(4, '0'))

	   localWork = Work.create(
                   # We don't actually have a title field
                   title:          (row[9].nil? ? "":row[9]) + " by " + (row[0].nil? ? "":row[0]) + " " + (row[1].nil? ? "":row[1]), 
	               orig_id:        (row[3].nil? ? nil : row[3].rjust(4, '0')),
	               orig_parent_id: (row[4].nil? ? nil : row[4].rjust(4, '0')),
	               full_orig_id:   (row[3].nil? ? "" : row[3].rjust(4, '0')) + "_" + (row[4].nil? ? "" : row[4].rjust(4, '0')),
	               medium:         (row[9].nil? ? "":row[9]),
	               parent_id:      (parentWork.nil? ? nil : parentWork.id),
	               artist_id:      localartist.id)
	
		
		work_representations.each do |filename| 
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


# @file = IO.read(params[:report].tempfile.path)
