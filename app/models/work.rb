class Work < ActiveRecord::Base
  acts_as_sane_tree
  belongs_to :artist
  has_many :work_representations, -> { order(:created_at) }
  
  def self.random
    if (c = count) != 0
      find(:first, :offset =>rand(c))
    end
  end  
end
