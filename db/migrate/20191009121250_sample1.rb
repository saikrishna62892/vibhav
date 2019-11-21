class Sample1 < ActiveRecord::Migration[6.0]
  def change
  	remove_column :blacklists, :created_at, :string

    remove_column :blacklists, :updated_at, :string
  end
end
