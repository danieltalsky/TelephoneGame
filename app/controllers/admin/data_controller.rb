require 'csv'
require 'open-uri'

class Admin::DataController < Admin::ApplicationController
  before_filter :authorize
  
  # Step 1
  def import_spreadsheet

    works_csv_url = "https://dl.dropboxusercontent.com/u/11147571/TelephoneDirectory-20140906.csv"
    artist_bios_url = "http://telephone.satellitepress.org/artistbios/"
    works_created = 0
    
    # populate artist bio file list
    artist_bios_html = open(artist_bios_url).read
    artist_bios = artist_bios_html.scan(/(?<=")\d\d\d\d[^<>]+(?=")/)    
  
    @data_report = "<h2>Starting spreadsheet import</h2>";  
    
    @data_report << "<h3>Opening works CSV URL: #{works_csv_url}</h3>";
    dir_str = open(works_csv_url).read    
    CSV.parse(dir_str) do |row2|
      row = row2.map{|item| (item.nil? ? "":item).sub(/[\*\s]*\z/,"").strip}
      
      # Skip header row
      if row[0] == 'First Name'
        next
      end
      
      localartist = Artist.create(name:    row[0] + " " + row[1],
                                  contact: row[11],
                                  url:     row[12],
                                  location:row[9] + " " + row[8] + " " + row[7])

      parentWork = Work.find_by_orig_id(row[5].rjust(4, '0'))

      # Create the work
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
      
      # Bios in markdown 
      artist_bios.each do |filename| 
        if filename.start_with?(localWork.full_orig_id)       
          tmp_fileext = filename.split(".").pop.downcase.chomp
          tmp_url = artist_bios_url + URI::encode(filename.chomp)
          if tmp_fileext == "md"
              localartist.update(bio: open(tmp_url).read)
          end
        end  
      end # artist_bios each
      
      # Vimeo URL's are a special case for videos where the work representation URL is stored in the spreadsheet
      if row[14][0,4]=='http'
        vimeoRep = WorkRepresentation.create(
            work_id: localWork.id,
            url: row[14].strip,
            fileext: 'vimeo'
        )        
      end  

      @data_report << "<div style=\"font-size:11px;\">Work created for artist: #{row[0] + " " + row[1]}.";
      
    end
    
    @data_report << "<h3>Total works created: #{works_created.to_s}</h3>";
    
  end #end import_spreadsheet
  
  
  
  
  # step 2
  def import_work_representations

    work_representations_url = "http://telephone.satellitepress.org/workrepresentations/"

    @data_report = "<h2>Starting work representations import</h2>";

    # Note that this way of getting a list of representations depends on the 
    # directory being viewable, which is suboptimal.
    @data_report << "<h3>Opening work representations URL: #{work_representations_url}</h3>";
    work_representations_html = open(work_representations_url).read
    work_representations = work_representations_html.scan(/(?<=")\d\d\d\d[^<>]+(?=")/)  
  
    worksList = Work.all
    worksList.each do |localWork|
    
      # Work representations
      work_representations_for_this_work = 0      
      work_representations.each do |filename| 

        if filename.start_with?(localWork.full_orig_id)
        
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

    @data_report << "<div>Work representations added: #{work_representations_for_this_work.to_s}</div>"
    
    end # works end    
 
  end
  
  
  
  
  #step 3
  def populate_tour
    
    @data_report = "<h2>Starting tour population</h2>";
    
    # Map of sequence ID's to orig_id's
    tour_map = {
      "1" => "0001_0000",
      "2" => "0002_0001",
      "3" => "0005_0002",
      "4" => "0013_0005",
      "5" => "0018_0013",
      "6" => "0033_0018",
      "7" => "0091_0033",
      "8" => "0189_0091",
      "9" => "0254_0189",
      "10" => "0307_0254",
      "11" => "0420_0307"
    }
    
    ctsList = CuratedTourStop.all
    ctsList.each do |cts| 
      original_id = tour_map[cts.sequential_id.to_s]
      associated_work = Work.find_by(full_orig_id: original_id)
      if associated_work.nil? 
        associated_work = Work.find_by(full_orig_id: "0001_0000")
        @data_report << "<div>Failed for original id #{original_id}</div>"
      end
      cts.work_id = associated_work.id
      cts.save
      @data_report << "<div>Assigned work to tour stop # #{cts.sequential_id.to_s}</div>"
    end
  end  

end


