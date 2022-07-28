class Post < ApplicationRecord
  validates_presence_of :title
  validates_presence_of :content
  validates_presence_of :address

  belongs_to :user
  belongs_to :category
  has_many :comments

  before_create :generate_unique_number

  def generate_unique_number
    loop do
      @short_num = 4.times.map{rand(9)}.join
      break unless Post.exists?(short_url: @short_num)
    end
    self.short_url = @short_num
  end

end
