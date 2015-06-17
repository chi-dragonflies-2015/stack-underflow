class Comment < ActiveRecord::Base
  belongs_to  :commented, polymorphic: true
  has_many    :votes, as :voted
  belongs_to  :user
end
