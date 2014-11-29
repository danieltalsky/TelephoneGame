class Artist < ActiveRecord::Base
  has_many :works
  
  def longname?
    nameList = self.name.split(" ")
    longname = false
    nameList.each do |nameToken|
      if nameToken.length > 9
        longname = true
      end
    end
    return longname
  end
end
