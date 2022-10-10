class User < ApplicationRecord
  has_many :tasks
  has_many :favorite, dependent: :destroy
  has_many :favorite_tasks, through: :favorites, source: :task

  has_secure_password

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  validates :birthday, presence: true
  validates :gender, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true

  enum gender: { male: 0, female: 1 }
end
