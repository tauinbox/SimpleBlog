class Comment < ActiveRecord::Base
  validates :body, presence: true, length: { maximum: 4000 }
  belongs_to :article
  belongs_to :user
  has_many :votes, as: :voting
  has_many :users, through: :votes
end
