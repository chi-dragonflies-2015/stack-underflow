class User < ActiveRecord::Base
  include BCrypt

  has_many  :questions
  has_many  :answers
  has_many  :votes
  has_many  :comments

  validates :email, { presence: true, uniqueness: true }
  validates :user_name, { presence: true, uniqueness: true }
  validates :password, { presence: true}

  def password
    @password ||= Password.new(self.password_hash)
  end

  def password=(new_password)
    self.password_hash = Password.create(new_password) # => BCrypt obj
  end

  def self.authenticate(user_name, received_password)
    user = User.find_by(user_name: user_name)
    if user && user.password == received_password
      user
      else
    nil
    end
  end

end
