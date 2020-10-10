class Work < ActiveRecord::Base
  acts_as_sane_tree
  belongs_to :artist
  has_many :work_representations, -> { order(:created_at) }
  
  def self.random
    order('RANDOM()').first
  end  
end
