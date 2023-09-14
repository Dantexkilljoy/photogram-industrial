class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :comments, foreign_key: "author_id", dependent: :destroy

  has_many :sent_follow_requests, foreign_key: :sender_id, class_name: "FollowRequest", dependent: :destroy

  has_many :accepted_sent_follow_requests, -> { accepted }, foreign_key: :sender_id, class_name: "FollowRequest"

  has_many :received_follow_requests, foreign_key: :recipient_id, class_name: "FollowRequest", dependent: :destroy

  has_many :accepted_received_follow_requests, -> { accepted }, foreign_key: :recipient_id, class_name: "FollowRequest", dependent: :destroy
  
  has_many :likes, class_name: "Like", foreign_key: :fan_id, dependent: :destroy 
  
  has_many :own_photos, class_name: "Photo", foreign_key: "owner_id", dependent: :destroy
  
  has_many :liked_photos, through: :likes, source: :photo, dependent: :destroy

  has_many :following, through: :accepted_sent_follow_requests, source: :recipient

  has_many :followers, through: :accepted_received_follow_requests, source: :sender

  has_many :feed, through: :leaders, source: :own_photos

  has_many :discover, through: :leaders, source: :liked_photos

  validates :username, presence: true, uniqueness: true

  scope :past_week, -> { where(created_at: 1.week.ago...) }

  scope :by_likes, -> { order(likes_count: :desc) }

end
