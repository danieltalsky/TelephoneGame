require 'csv'
require 'open-uri'


class Admin::DataController < Admin::ApplicationController

  def seed

    # Note that this way of getting a list of representations depends on the 
    # directory being viewable, which is suboptimal.
    work_representations_html = open("http://telephone.satellitepress.org/workrepresentations/").read
    work_representations = work_representations_html.scan(/(?<=")\d\d\d\d[^<>]+(?=")/)

    # Note that this way of getting a list of representations depends on us 
    # keeping an up-to-date list in my Dropbox, which is suboptimal.    
    #work_representations = open("http://dl.dropboxusercontent.com/u/418477/reps.txt").read
    
    dir_str = open("https://dl.dropboxusercontent.com/u/418477/Telephone%20Directory%202014-06-11.csv").read
    CSV.parse(dir_str) do |row2|
      row = row2.map{|item| (item.nil? ? "":item).sub(/[\*\s]*\z/,"").strip}
      
      localartist = Artist.create(name:    row[0] + " " + row[1],
                                  contact: row[11],
                                  bio:     row[6], # We don't actually have a bio field
                                  url:     row[12],
                                  location:row[9] + " " + row[8] + " " + row[7])

      parentWork = Work.find_by_orig_id(row[5].rjust(4, '0'))

      localWork = Work.create(
                   # We don't actually have a title field
                   title:          row[10] + " by " + row[0] + " " + row[1], 
                   orig_id:        row[4].rjust(4, '0'),
                   orig_parent_id: row[5].rjust(4, '0'),
                   full_orig_id:   row[4].rjust(4, '0') + "_" + row[5].rjust(4, '0'),
                   medium:         row[10],
                   parent_id:      (parentWork.nil? ? nil : parentWork.id),
                   artist_id:      localartist.id)

      work_representations.each do |filename| 
        if filename.start_with?(localWork.full_orig_id)
          # This originally created the WorkRep and then added the text_body_markdown only if
          # there was an md file in the directory. That is a better way to do this, but I am on a time crunch.
          
          tmp_fileext = filename.split(".").pop.downcase.chomp
          tmp_url = 'http://telephone.satellitepress.org/workrepresentations/' + URI::encode(filename.chomp)
          if tmp_fileext == "md"
              localRep = WorkRepresentation.create(
                  work_id: localWork.id,
                  url: tmp_url,
                  fileext: tmp_fileext,
                  text_body_markdown: open(tmp_url).read
              )
          else
              localRep = WorkRepresentation.create(
                  work_id: localWork.id,
                  url: tmp_url,
                  fileext: tmp_fileext,
              )
          end
        end
      end

    end
  end
end


# @file = IO.read(params[:report].tempfile.path)
