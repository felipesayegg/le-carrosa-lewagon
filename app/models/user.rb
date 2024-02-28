class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # we code dependent detroy because when someone delete her or his profile
  # the cars that belongs to the profile go out with them.
  has_many :cars, dependent: :destroy

  has_many :orders
end
