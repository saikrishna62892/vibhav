class CreateBookings < ActiveRecord::Migration[6.0]
  def change
    create_table :bookings do |t|
    	t.string :colege_id
    	t.string :name
		t.string :phone
		t.string :address
		t.string :veg_name
		t.string :quantity
		t.string :price

      t.timestamps
    end
  end
end
