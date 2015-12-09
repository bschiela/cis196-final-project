class User < ActiveRecord::Base
  # associations
  has_many :sounds, dependent: :destroy
  has_many :playlists, dependent: :destroy

  # profile picture
  has_attached_file :image,
    styles: { medium: "300x300>", thumb: "100x100>" },
    default_url: "/images/user_image.png"
  # Validate content type
  validates_attachment_content_type :image, content_type: /\Aimage/
  # Validate filename
  validates_attachment_file_name :image, matches: [/png\Z/, /jpe?g\Z/]

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
