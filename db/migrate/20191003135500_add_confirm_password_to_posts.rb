class AddConfirmPasswordToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :confirm_password, :string
  end
end
