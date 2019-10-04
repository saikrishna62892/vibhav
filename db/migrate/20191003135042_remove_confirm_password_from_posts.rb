class RemoveConfirmPasswordFromPosts < ActiveRecord::Migration[6.0]
  def change
  	remove_column :posts,:confirm_password
  end
end
