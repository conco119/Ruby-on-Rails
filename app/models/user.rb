class User < ApplicationRecord
  before_save :downcase_email

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, presence: true, length: {maximum: 25}
  validates :password, presence: true, length: {minimum: 6}
  validates :email, presence: true, length: {maximum: 225},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}

  has_secure_password
  private
  def downcase_email
    self.email = email.downcase
  end
end
