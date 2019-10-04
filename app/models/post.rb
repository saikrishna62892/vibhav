class Post < ApplicationRecord
#	attr_accessible :collegeid, :name, :dept, :type, :course, :phone, :address
	has_secure_password
	validates :collegeid, :name, :dept, :course, :phone, :address,:password,:email,:confirm_password,:presence => true
	validates :collegeid, :length => { :minimum => 3}
	validates :password,:confirm_password, :length => {:minimum => 5}
	validates :phone, length: { is: 10 }
	validates :phone, numericality: { only_integer: true }
	validates :collegeid, :phone,:email, uniqueness: true
	validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
