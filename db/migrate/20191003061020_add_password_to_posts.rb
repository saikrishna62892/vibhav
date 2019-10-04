class AddPasswordToPosts < ActiveRecord::Migration[6.0]
  def change
    remove_column :posts, :password, :string
  end
end
