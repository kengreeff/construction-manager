class User < ApplicationRecord
  has_secure_password

  generates_token_for :email_verification, expires_in: 2.days do
    email
  end
  generates_token_for :password_reset, expires_in: 20.minutes do
    password_salt.last(10)
  end

  belongs_to :role
  
  has_many :clients_users
  has_many :clients, through: :clients_users
  has_many :organizations_users
  has_many :organizations, through: :organizations_users
  has_many :sessions, dependent: :destroy

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, allow_nil: true, length: { minimum: 12 }

  normalizes :email, with: -> { _1.strip.downcase }

  before_validation if: :email_changed?, on: :update do
    self.verified = false
  end

  after_update if: :password_digest_previously_changed? do
    sessions.where.not(id: Current.session).delete_all
  end

  def admin?
    self.role&.key == 'admin'
  end

  def client_user?
    self.role&.key == 'client_user'
  end

  def organization_user?
    self.role&.key == 'organization_user'
  end

  def full_name
    if self.first_name.present?
      return "#{self.first_name} #{self.last_name}"
    end

    return "No Name Set"
  end
end
