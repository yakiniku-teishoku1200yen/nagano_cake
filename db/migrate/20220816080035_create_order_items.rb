class CreateOrderItems < ActiveRecord::Migration[6.1]
  def change
    create_table :order_items do |t|
      t.integer :item_id, null: false
      t.integer :order_id, null: false
      t.integer :order_quantity, null: false
      t.integer :crafting_status, null: false, default: 0
      t.integer :price, null: false

      t.timestamps null: false
    end
  end
end
