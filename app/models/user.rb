class User < ActiveRecord::Base
  # validations
  validates :username, presence: true, uniqueness: true, length: { minimum: 4, maximum: 15 }
  validates :name, presence: true
  validates :password_hash, presence: true
  validates :email, presence: true

  # users.password_hash in the database is a :string
  include BCrypt

  def password
    @password ||= Password.new(password_hash) unless password_hash.nil?
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end
