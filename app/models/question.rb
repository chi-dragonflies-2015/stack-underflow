class Question < ActiveRecord::Base
  has_many :comments, as: :commented
  has_many :votes, as: :voted
  belongs_to :best_answer, class_name: "Answer"
  has_many  :answers
  belongs_to  :user
  has_many :voters, through: :votes, source: :user

  validates :title, { presence: true }
  validates :body, { presence: true }

  def eligible_voter? (user)
    !self.voters.include?(user)
  end
end
