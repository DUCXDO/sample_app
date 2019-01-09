class Micropost < ApplicationRecord
  belongs_to :user
  scope :feed_sort, ->{order created_at: :desc}
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: Settings.post_cont_max}
  validate :picture_size

  private

  def picture_size
    return unless picture.size > Settings.picture_max_size.megabytes
    errors.add :picture, t(".picture_wrong_size")
  end
end
