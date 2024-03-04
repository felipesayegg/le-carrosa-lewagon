class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # we code dependent detroy because when someone delete her or his profile
  # the cars that belongs to the profile go out with them.
  has_many :cars, dependent: :destroy

  has_many :orders

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, if: :password_required?
  validates :password_confirmation, presence: true, if: :password_required?

  # Add any additional validations as needed...

  private

  def password_required?
    !persisted? || password.present? || password_confirmation.present?
  end
end
