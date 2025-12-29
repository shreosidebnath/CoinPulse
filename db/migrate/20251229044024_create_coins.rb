class CreateCoins < ActiveRecord::Migration[7.1]
  def change
    create_table :coins do |t|
      t.string :coingecko_id
      t.string :name
      t.string :symbol
      t.decimal :current_price

      t.timestamps
    end
  end
end
