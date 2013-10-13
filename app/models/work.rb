class Work < ActiveRecord::Base
  acts_as_sane_tree
  belongs_to :artist
end
