class User < ApplicationRecord
  before_save { self.email = self.email.downcase }

  has_many :tasks
  has_many :favorites, dependent: :destroy
  has_many :favorite_tasks, through: :favorites, source: :task

  has_secure_password

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, uniqueness: true,
                    format: { with: VALID_EMAIL_REGEX },
                    length: { maximum: 254 }
  validates :birthday, presence: true
  validates :gender, presence: true
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true  
  #validates :guest, default: false, null: false

  enum gender: { male: 0, female: 1 }

  def generate_1990
    User.where(birthday: Time.local(1990,1,1)..Time.local(1999,12,31))
  end
end
