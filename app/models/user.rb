class User < ApplicationRecord
  has_many :ideas
  has_many :likes
  has_many :like_ideas, through: :likes, source: :idea


  before_save {self.email = email.downcase}
  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[a-zA-Z0-9_\#!$%&`'*+\-{|}~^\/=?\.]+@[a-z0-9][a-z0-9\.-]+\z/i
  validates :email, presence: true, length: {maximum: 255}, format: {with: VALID_EMAIL_REGEX},
          uniqueness: {case_sensitive: false}
  has_secure_password
end
