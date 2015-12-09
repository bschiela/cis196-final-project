class Event < ActiveRecord::Base
  # associations
  belongs_to :user

  # associated image
  has_attached_file :image,
    styles: { medium: "300x300>", thumb: "100x100>" },
    default_url: "/images/event_image.png"
  validates_attachment_content_type :image, content_type: /\Aimage/
  validates_attachment_file_name :image, matches: [/png\Z/, /jpe?g\Z/]

  # validations
  validates :name, presence: true
  validates :start_datetime, presence: true
  validate :valid_end_datetime

  def valid_end_datetime
    if end_datetime && (end_datetime <= start_datetime)
      errors.add(:end_datetime, 'Event cannot end before it starts')
    end
  end
end
