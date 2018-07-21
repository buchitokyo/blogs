class Blog < ApplicationRecord
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
  belongs_to :user

  validates :title,:content, presence: true
  validates :content, length:  { in: 1..140 }

  mount_uploader :image, ImageUploader
end
