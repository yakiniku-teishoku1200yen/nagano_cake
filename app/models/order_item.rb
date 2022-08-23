class OrderItem < ApplicationRecord
  belongs_to :item
  belongs_to :order

enum crafting_status: { production_not_allowed: 0, waiting_for_production: 1, production: 2, production_completed: 3 }

 def with_tax_price
    (price * 1.1).floor
 end
 def subtotal
    item.price * order_quantity
 end

end
