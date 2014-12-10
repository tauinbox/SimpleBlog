class Vote < ActiveRecord::Base
  belongs_to :voting, polymorphic: true
  belongs_to :user
end
