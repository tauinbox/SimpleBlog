class Article < ActiveRecord::Base
  validates :title, presence: true
  validates :text, presence: true

  has_many :comments
  belongs_to :user

  def subject
    title
  end

  def last_comment
    comments.last
  end
  
end
