class Supplier < ApplicationRecord
  validates :level, :email, presence: true
  has_many :supplier_items
  default_scope { order(created_at: :desc) }
end
