class User < ApplicationRecord

  mount_uploader :avatar, AvatarUploader

  has_many :ideas
  has_many :likes, dependent: :destroy
  has_many :like_ideas, through: :likes, source: :idea

  has_many :following_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :following_users, through: :following_relationships, source: :followed

  has_many :followed_relationships, class_name:  "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followed_users, through: :followed_relationships, source: :follower

  before_save {self.email = email.downcase}
  validates :name, presence: true, length: {maximum: 50}, uniqueness: {case_sensitive: true}
  VALID_EMAIL_REGEX = /\A[a-zA-Z0-9_\#!$%&`'*+\-{|}~^\/=?\.]+@[a-z0-9][a-z0-9\.-]+\z/i
  validates :email, presence: true, length: {maximum: 255}, format: {with: VALID_EMAIL_REGEX},
          uniqueness: {case_sensitive: false}
  has_secure_password

  # フォローする
  def follow(other_user)
    following_relationships.find_or_create_by(followed_id: other_user.id)
  end

  # フォロー取り消し
  def unfollow(other_user)
    following_relationship = following_relationships.find_by(followed_id: other_user.id)
    following_relationship.destroy if following_relationship
  end

  # followしているかどうか
  def following?(other_user)
    following_users.include?(other_user)
  end

  def feed_items
    Idea.where(user_id: following_user_ids + [self.id])
  end

  def set_image(file)
    if !file.nil?
      file_name = file.original_filename
      File.open("public/user_images/#{file_name}", 'wb') { |f| f.write(file.read) }
      self.avatar = file_name
    end
  end
end
