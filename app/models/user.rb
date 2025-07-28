class User < ApplicationRecord
  has_secure_password

  # Role constants:
  ROLE_CHEF = 0
  ROLE_MANAGER = 1

  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }, if: -> { password.present? }

  def manager?
    role == ROLE_MANAGER
  end

  def chef?
    role == ROLE_CHEF
  end
end
