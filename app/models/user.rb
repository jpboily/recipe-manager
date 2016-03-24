class User < ActiveRecord::Base
  attr_accessor :remember_token

  # Make sure email is saved with downcase letters
  before_save { email.downcase! }

  # User name needs to be present and have a maximum of 50 chars
  validates :name, presence: true, length: { maximum: 50 }

  # Regular Expression to validate email address
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  # Email address MUST comply to following rules:
  #  - not blank
  #  - maximum of 255 chars
  #  - matches the regular expression VALID_EMAIL_REGEX
  #  - is unique
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  # Using the has_secure_password to encrypt the password
  has_secure_password

  # Password is mandatory and must have a minimum of 6 chars
  # TODO : Add more restrictions on the password pattern
  validates :password, presence: true, length: { minimum: 6 }

  class << self
      # Returns the hash digest of the given string.
      def digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
      end

      # Returns a random token.
      def new_token
        SecureRandom.urlsafe_base64
      end
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end
end
