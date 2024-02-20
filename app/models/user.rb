class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #add validates for user
  validates :name, presence: true
  validates :phone_number, presence: true
  validates :role, presence: true, inclusion: { in: %w(admin customer) }
end
