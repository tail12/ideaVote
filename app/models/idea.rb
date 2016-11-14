class Idea < ApplicationRecord
  belongs_to :user
  has_many :likes
  has_many :liking_users, through: :likes, source: :user

  validates :user_id, presence: true
  validates :idea_name, presence: true
  # validates :content, presence: true, length: {minimum: 20, maximum: 300}

end
