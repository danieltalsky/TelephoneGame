require 'csv'
require 'open-uri'


class Admin::DataController < Admin::ApplicationController

  def seed

    work_representations_url = "http://telephone.satellitepress.org/workrepresentations/"
    works_csv_url = "https://dl.dropboxusercontent.com/u/11147571/TelephoneDirectory-20140828.csv"
    works_created = 0
  
    @data_report = "<h2>Starting import</h2>";
    
    # Note that this way of getting a list of representations depends on the 
    # directory being viewable, which is suboptimal.
    # Also, to pull all jpegs out of foldersm log into the work reps directory and do:
    # find . -iname '*.jpg' -exec cp \{\} ./ \;
    # and then:
    # rm -r */
    # to delete the directories themselves
    @data_report << "<h3>Opening work representations URL: #{work_representations_url}</h3>";
    work_representations_html = open(work_representations_url).read
    work_representations = work_representations_html.scan(/(?<=")\d\d\d\d[^<>]+(?=")/)

    # Note that this way of getting a list of representations depends on us 
    # keeping an up-to-date list in my Dropbox, which is suboptimal.    
    
    @data_report << "<h3>Opening works CSV URL: #{works_csv_url}</h3>";
    dir_str = open(works_csv_url).read
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

      works_created += 1             
      
      work_representations_for_this_work = 0      
      work_representations.each do |filename| 

        if filename.start_with?(localWork.full_orig_id)
        
          # This originally created the WorkRep and then added the text_body_markdown only if
          # there was an md file in the directory. That is a better way to do this, but I am on a time crunch.
          
          tmp_fileext = filename.split(".").pop.downcase.chomp
          tmp_url = work_representations_url + URI::encode(filename.chomp)
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
          work_representations_for_this_work += 1
        end
       
      end # work_representations each

      @data_report << "<div style=\"font-size:11px;\">Work created for artist: #{row[0] + " " + row[1]}.  Work representations added: #{work_representations_for_this_work.to_s}</div>";
      
    end
    
    @data_report << "<h3>Total works created: #{works_created.to_s}</h3>";
    
  end #end seed
  
  
end


# @file = IO.read(params[:report].tempfile.path)
