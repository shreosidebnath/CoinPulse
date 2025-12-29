class CreatePriceSnapshots < ActiveRecord::Migration[7.1]
  def change
    create_table :price_snapshots do |t|
      t.references :coin, null: false, foreign_key: true
      t.decimal :price
      t.datetime :recorded_at

      t.timestamps
    end
  end
end
