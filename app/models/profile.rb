class Profile < ActiveRecord::Base
  belongs_to :user
  has_one :image, as: :imageable
  accepts_nested_attributes_for :image
end
