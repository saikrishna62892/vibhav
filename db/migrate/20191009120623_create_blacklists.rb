class CreateBlacklists < ActiveRecord::Migration[6.0]
  def change
    create_table :blacklists do |t|
    	t.string :colege_id
    	
      t.timestamps
    end
  end
end
