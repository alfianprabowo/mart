class Store < ApplicationRecord
  validates :name, :address, :phone, presence: true
  has_many :users
  has_many :store_items
  has_many :retur

  enum store_type:{
    retail: 0,
    warehouse: 1
  }
end

