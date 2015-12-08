class Sound < ActiveRecord::Base
  # associations
  belongs_to :user

  # associated image
  has_attached_file :image,
    styles: { medium: "300x300>", thumb: "100x100>" },
    default_url: "/images/sound_image.png"
  validates_attachment_content_type :image, content_type: /\Aimage/
  validates_attachment_file_name :image, matches: [/png\Z/, /jpe?g\Z/]

  # associated audio
  has_attached_file :audio
  validates_attachment_content_type :audio, content_type: /\Aaudio/
  validates_attachment_file_name :audio, matches: [/mp3\Z/, /mpe?g\Z/]

  # validations
  validates :name, presence: true
  validates :audio, presence: true

end
