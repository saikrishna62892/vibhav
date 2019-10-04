class RemovePasswordDigestFromPosts < ActiveRecord::Migration[6.0]
  def change
  	remove_column :posts,:password_digest, :confirm_password
  end
end
