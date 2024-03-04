class Car < ApplicationRecord
  include PgSearch::Model

  has_many_attached :photos
  belongs_to :user
  has_one :order

  validates :user_id, presence: true
  validates :year, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1900 }
  validates :brand, presence: true
  validates :mod, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :km, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true


  pg_search_scope :search_by_mod_and_brand,
    against: [:mod, :brand],
    using: {
      tsearch: { prefix: true } # Pesquisa de prefixo para ambos os campos
    }
end
