class Question < ActiveRecord::Base
  has_many :comments, as :commented
  has_many :votes, as :voted
  belongs_to :best_answer, class_name: "Answer"
  has_many  :answers
  belongs_to  :user
end
