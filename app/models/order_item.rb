class OrderItem < ApplicationRecord
  belongs_to :item
  belongs_to :order

enum crafting_status: { production_not_allowed: 0, waiting_for_production: 1, production: 2, production_completed: 3 }
end
