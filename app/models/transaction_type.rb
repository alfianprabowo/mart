class TransactionType < ApplicationRecord
	validates :name,  presence: true
  	#belongs_to :transaction
end
