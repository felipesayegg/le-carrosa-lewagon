class Car < ApplicationRecord
  has_many_attached :photos
  belongs_to :user
  has_one :order
  
  validates :user_id, presence: true
  validates :year, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1900 }
  validates :brand, presence: true
  validates :mod, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :km, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true
end
