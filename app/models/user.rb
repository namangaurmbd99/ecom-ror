class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :addresses, dependent: :destroy
  has_one :cart, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :payments, through: :orders, dependent: :destroy

  validates :name, presence: true
  validates :phone_number, presence: true
  validates :role, presence: true, inclusion: { in: %w(admin customer) }

  # Define role enums
  enum role: { admin: 'admin', customer: 'customer' }

  # Define role check methods
  def admin?
    role == 'admin'
  end

  def customer?
    role == 'customer'
  end
end
