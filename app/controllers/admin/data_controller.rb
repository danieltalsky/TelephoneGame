require 'csv'
require 'open-uri'

class Admin::DataController < Admin::ApplicationController
  before_filter :authorize
  
  # Step 1
  def import_spreadsheet
 
    works_csv_url = "https://dl.dropboxusercontent.com/u/11147571/TelephoneDirectory-20150414.csv"
    works_created = 0
  
    @data_report = "<h2>Starting spreadsheet import</h2>"
    
    @data_report << "<h3>Opening works CSV URL: #{works_csv_url}</h3>"
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
                                  location:row[9] + (row[9].empty? ? "" : ", ") + row[8] + (row[8].empty? ? "" : ", ") + row[7])

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
      
      # Vimeo URL's are a special case for videos where the work representation URL is stored in the spreadsheet
      if row[14][0,4]=='http'
        vimeoRep = WorkRepresentation.create(
            work_id: localWork.id,
            url: row[14].strip,
            fileext: 'vimeo'
        )        
      end  

      @data_report << "<div style=\"font-size:11px;\">Work created for artist: #{row[0] + " " + row[1]}.</div>";
      
    end
    
    @data_report << "<h3>Total works created: #{works_created.to_s}</h3>";
    
  end #end import_spreadsheet
  
  def import_bios

    artist_bios_url = "http://telephoneassets.satellitecollective.org/artistbios/"

    @data_report = "<h2>Starting artist bio import</h2>";

    # populate artist bio file list
    artist_bios_json = open(artist_bios_url).read
    artist_bios = JSON.parse(artist_bios_json)    
  
    # Bios in markdown 
    artist_bios.each do |filename| 
      
      filename_id_prefix = filename[0,9]
      work = Work.find_by full_orig_id: filename_id_prefix 
      if ! work.nil?
        artist = Artist.find_by_id work.artist_id
      else
        @data_report << "<div style=\"font-size:10px; background: pink;\">Couldn't find an artist for this file: #{filename}.</div>";
      end
      
      if ! artist.nil?      
        filetype = filename.split(".").pop.downcase.chomp       
        if filetype == "md"
            biopath = artist_bios_url + URI::encode(filename.chomp)
            artist.update(bio: open(biopath).read)
            @data_report << "<div style=\"font-size:10px;\">Bio added for artist: #{artist.name}.</div>";
        end
      end  
    end # artist_bios each  
  
  end #end import_bios
  
  
  # step 3
  def import_work_representations

    # json file list
    work_representations_url = "http://telephoneassets.satellitecollective.org/"

    @data_report = "<h2>Starting work representations import</h2>";

    @data_report << "<h3>Opening work representations URL: #{work_representations_url}</h3>";
    work_representations_json = open(work_representations_url).read
    work_representations = JSON.parse(work_representations_json)  
  
    worksList = Work.all
    worksList.each do |localWork|
    
      # Work representations
      work_representations_for_this_work = 0      
      work_representations.each do |filename| 

        if filename.start_with?(localWork.full_orig_id)
        
          tmp_fileext = filename.split(".").pop.downcase.chomp
          tmp_url = work_representations_url + URI::encode(filename.chomp)
          # If the file is a markdown file, store the actual text contents instead of a URL to the work
          if tmp_fileext == "md"
              localRep = WorkRepresentation.create(
                  work_id: localWork.id,
                  url: tmp_url,
                  fileext: tmp_fileext,
                  text_body_markdown: open(tmp_url).read
              )
          # If the file is a text file with just a URL in it, store the contents in URL
          elsif tmp_fileext == "url"   
               localRep = WorkRepresentation.create(
                  work_id: localWork.id,
                  url: open(tmp_url).read,
                  fileext: tmp_fileext
              )    
          # Otherwise just import a URL to the work representation
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
  
  
  
  
  #step 4
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
  
  
  def tests
    render :text => "<pre>" + 'No Tests' + "</pre>".html_safe
  end

end

