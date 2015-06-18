class Vote < ActiveRecord::Base
  belongs_to  :question, polymorphic: true
  belongs_to  :answer, polymorphic: true
  belongs_to  :comment, polymorphic: true
  belongs_to  :user

  validates :value, :inclusion => { :in => [1, -1]}
end
#filler
