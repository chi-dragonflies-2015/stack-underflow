class Answer < ActiveRecord::Base
  has_many :comments, as: :commented
  has_many :votes, as: :voted
  belongs_to  :question
  belongs_to  :user
  has_many :voters, through: :votes, source: :user

  validates :body, { presence: true }

  def eligible_voter?(user)
    !self.voters.include?(user) && self.user != user
  end
end
