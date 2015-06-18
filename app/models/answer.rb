class Answer < ActiveRecord::Base
  has_many :comments, as: :commented
  has_many :votes, as: :voted
  belongs_to  :question
  belongs_to  :user

  validates :body, { presence: true }

  def reputation
    votes.pluck(:value).reduce(:+) || 0
  end
end
