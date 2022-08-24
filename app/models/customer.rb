class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :addresses, dependent: :destroy

  validates :last_name, :first_name, :last_name_kana, :first_name_kana, :email, :post_code, :address, :phone_number,
            :encrypted_password, presence: true
  validates :post_code, length: { is: 7 }

  def full_name
    last_name + first_name
  end

  def full_name_kana
    last_name_kana + first_name_kana
  end
end
