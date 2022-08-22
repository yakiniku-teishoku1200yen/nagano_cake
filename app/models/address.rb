class Address < ApplicationRecord
  belongs_to :customer

  def address_display
  '〒' + post_code + ' ' + shipping_address + ' ' + name
  end
end
