class AddEmailToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :email, :string
    add_column :posts, :string, :string
  end
end
