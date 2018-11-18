class ReturnItem < ApplicationRecord
  validates :item_id,:return_id, :quantity, :description, presence: true
  belongs_to :item
  belongs_to :return
end
