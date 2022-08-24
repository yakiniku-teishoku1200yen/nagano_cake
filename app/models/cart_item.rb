class CartItem < ApplicationRecord
  belongs_to :item
  belongs_to :customer

  validates :customer_id, :item_id, :amount, presence: true

  def subtotal
    (item.price * amount * 1.1).floor
  end
end