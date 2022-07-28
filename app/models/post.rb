class Post < ApplicationRecord
  validates_presence_of :title
  validates_presence_of :content
  validates_presence_of :address

  belongs_to :user
  has_many :comments

end
