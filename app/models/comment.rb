class Comment < ActiveRecord::Base
  belongs_to  :commented, polymorphic: true
  has_many    :votes, as: :voted
  belongs_to  :user
  has_many :voters, through: :votes, source: :user

  validates :body, { presence: true }
end
