class User < ActiveRecord::Base
  has_many  :questions
  has_many  :answers
  has_many  :votes
  has_many  :comments

  validates :email, { presence: true, uniqeness: true }
  validates :username, { presence: true, uniqeness: true }
  validates :password_hash { presence: true, uniqeness: true }

  def password
    @password ||= Password.new(self.password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password
    self.password_hash = @password # => BCrypt obj
  end

  def self.authenticate(username, password)
    user = User.find_by(username: username)
    if user && user.password_hash == password
      user
    else
      nil
    end
  end

end
