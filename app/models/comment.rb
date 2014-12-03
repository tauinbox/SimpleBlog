class Comment < ActiveRecord::Base
  validates :body, presence: true, length: { maximum: 4000 }
  belongs_to :article
  belongs_to :user
end
