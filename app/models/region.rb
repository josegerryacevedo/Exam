class Region < ApplicationRecord
  validates_presence_of :region_name
  has_many :posts
end
