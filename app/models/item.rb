class Item < ApplicationRecord
  validates :item_cat_id, :name, :buy, :sell, :code, presence: true
  belongs_to :item_cat
  has_many :store_items
  has_many :retur_items
end

