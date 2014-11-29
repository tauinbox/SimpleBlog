class Profile < ActiveRecord::Base
  belongs_to :user
  has_one :image, as: :imageable
end
