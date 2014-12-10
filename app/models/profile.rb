class Profile < ActiveRecord::Base
  belongs_to :user
  has_one :image, as: :imageable
  has_many :votes, as: :voting
  has_many :users, through: :votes
  accepts_nested_attributes_for :image
end
