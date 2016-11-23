class Product < ApplicationRecord
  scope :low_stock, -> { where("stock < 20").order(stock: :asc) }


end
