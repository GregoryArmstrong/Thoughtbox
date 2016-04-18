class User < ActiveRecord::Base
  has_secure_password
  has_many :user_roles
  has_many :roles, through: :user_roles

  validates :username, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email_address, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password_digest, presence: true, length: { minimum: 6 }, allow_nil: true

  def registered_user?
    roles.exists?(name: "registered_user")
  end

end
