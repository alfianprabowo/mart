class CreateTransactionTypes < ActiveRecord::Migration[5.2]
  def change
    add_column :transaction_types, :name, :string, null: false
  end
end
