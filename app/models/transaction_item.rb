class TransactionItem < ApplicationRecord
  validates :item_id, :transaction_id, presence: true
  belongs_to :item
  belongs_to :transaction
end

