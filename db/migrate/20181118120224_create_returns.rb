class CreateReturns < ActiveRecord::Migration[5.2]
  def change
    create_table :returns do |t|
      t.string :invoice, null: false
      t.integer :total_items, null: false
      t.references :store, foreign_key: true, null: false
      t.datetime :date_created, default: 'CURRENT_TIMESTAMP'
      t.datetime :status
    end
  end
end
