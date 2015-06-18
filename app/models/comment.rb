class Comment < ActiveRecord::Base
  belongs_to  :commented, polymorphic: true
  has_many    :votes, as: :voted
  belongs_to  :user

  validates :body, { presence: true }

  def reputation
    votes.pluck(:value).reduce(:+) || 0
  end
end