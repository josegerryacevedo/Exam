class Post < ApplicationRecord
  validates_presence_of :title
  validates_presence_of :content
  validates_presence_of :address

  belongs_to :user

end
