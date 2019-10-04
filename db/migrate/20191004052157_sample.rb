class Sample < ActiveRecord::Migration[6.0]
  def change
  	change_column :vegetables, :quantity, :decimal, :precision =>6, :scale => 2
    change_column :vegetables, :price, :decimal, :precision =>6, :scale => 2
  end
end
