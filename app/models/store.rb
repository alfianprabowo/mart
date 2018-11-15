class Store < ApplicationRecord
  validates :name, :address, :phone, presence: true
  has_many :users
  has_many :store_items
end

