class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :collegeid
      t.string :name
      t.string :dept
      t.string :type
      t.string :course
      t.string :phone
      t.string :address
      
      t.timestamps
    end
  end
end
