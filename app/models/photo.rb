class Photo < ApplicationRecord
  # belongs_to :owner, counter_cache: true
  belongs_to :owner, class_name: "User"

  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :fans, through: :likes

  validates :caption, presence: true
  validates :image, presence: true

  scope :past_week, -> { where(created_at: 1.week.ago...) }
  scope :by_likes, -> { order(likes_count: :desc) }
end
