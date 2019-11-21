class Vegetable < ApplicationRecord
	validates :veg_name,:quantity,:price,:presence => true
	validates :quantity,:price, numericality: true
	validates :veg_name,:uniqueness=>true
end
