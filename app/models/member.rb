class Member < ApplicationRecord
  validates :item_cat_id, :name,:stock, :buy, :sell, :code, presence: true
end

