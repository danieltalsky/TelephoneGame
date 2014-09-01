class CuratedTourStop < ActiveRecord::Base
  belongs_to :work
  belongs_to :curated_tour
  acts_as_sequenced scope: :curated_tour_id
end
