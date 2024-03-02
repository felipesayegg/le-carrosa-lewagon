class Order < ApplicationRecord
  belongs_to :user
  belongs_to :car

  validates :date, presence: true
  validates :user_id, presence: true
  validates :car_id, presence: true
end
