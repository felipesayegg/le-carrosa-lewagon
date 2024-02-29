class Car < ApplicationRecord
  has_many_attached :photos
  belongs_to :user
  has_one :order
end
