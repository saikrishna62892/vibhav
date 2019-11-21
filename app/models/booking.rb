class Booking < ApplicationRecord
	validates :veg_name,:quantity,:presence => true
	validates :quantity, numericality: true
end
