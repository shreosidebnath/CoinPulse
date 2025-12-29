class CreateHoldings < ActiveRecord::Migration[7.1]
  def change
    create_table :holdings do |t|
      t.references :portfolio, null: false, foreign_key: true
      t.references :coin, null: false, foreign_key: true
      t.decimal :amount
      t.decimal :purchase_price

      t.timestamps
    end
  end
end
