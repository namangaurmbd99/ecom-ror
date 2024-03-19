class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :omniauthable, omniauth_providers: [:google_oauth2, :facebook]
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  has_many :addresses, dependent: :destroy
  has_one :cart, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :payments, through: :orders, dependent: :destroy

  # Validations
  validates :name, :phone_number, presence: true
  validates :role, presence: true, inclusion: { in: %w(admin customer) }

  # Enums
  enum role: { admin: 'admin', customer: 'customer' }

  # Methods
  def admin?
    role == 'admin'
  end

  def customer?
    role == 'customer'
  end
end
