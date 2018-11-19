class ReturItem < ApplicationRecord
  validates :item_id,:retur_id, :quantity, :description, presence: true
  belongs_to :item
  belongs_to :retur
end

