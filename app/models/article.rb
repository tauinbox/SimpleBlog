class Article < ActiveRecord::Base
  validates :title, presence: true, length: { maximum: 140 }
  validates :text, presence: true, length: { maximum: 4000 }

  has_many :comments, dependent: :destroy
  belongs_to :user
  has_many :images, as: :imageable, dependent: :destroy
  has_many :votes, as: :voting, dependent: :destroy
  has_many :users, through: :votes

  accepts_nested_attributes_for :images

  def subject
    title
  end

  def last_comment
    comments.last
  end
  
  def comments_count
    comments.count
  end

  def votes_sum
    sum = 0
    votes.each { |vote| sum += vote.value }
    sum
  end
  
end
