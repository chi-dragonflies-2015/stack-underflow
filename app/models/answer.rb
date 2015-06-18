class Answer < ActiveRecord::Base
  has_many :comments, as: :commented
  has_many :votes, as: :voted
  belongs_to  :question
  belongs_to  :user
  has_many :voters, through: :votes, source: :user

  validates :body, { presence: true }
end
