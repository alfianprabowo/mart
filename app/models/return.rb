class Return < ApplicationRecord
  validates :total_items, :store_id, presence: true
  has_many :return_items
  belongs_to :store
end

