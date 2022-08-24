class Item < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :order_items, dependent: :destroy
  belongs_to :genre

  has_one_attached :image

  validates :genre_id, :name, :price, presence: true
  validates :explanation, length: { maximum: 150 }
  validates :is_ordered, inclusion: { in: [true, false] }

  def with_tax_price
    (price * 1.1).floor
  end

  def get_image(width,height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no-image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width,height]).processed
  end

  def add_tax_sales_price
  (self.price * 1.10).round
  end

  def taxin_price
    price*1.1
  end
end
