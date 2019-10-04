class CreateVegetables < ActiveRecord::Migration[6.0]
  def change
    create_table :vegetables do |t|
    	t.string :veg_name
    	t.decimal :quantity, :precision => 6,:scale =>2
    	t.decimal :price, :precision => 6,:scale =>2

      t.timestamps
    end
  end
end
