class Story < ActiveRecord::Base
  # associations
  belongs_to :user

  # associated image
  has_attached_file :image,
    styles: { medium: "300x300>", thumb: "100x100>" },
    default_url: "/images/story_image.png"
  validates_attachment_content_type :image, content_type: /\Aimage/
  validates_attachment_file_name :image, matches: [/png\Z/, /jpe?g\Z/]

  # validations
  validates :headline, presence: true
  validates :body, presence: true
end
