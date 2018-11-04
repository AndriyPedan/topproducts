class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.integer :external_id, null: false
      t.integer :category_id, null: false
      t.integer :vendor_id, null: false
      t.integer :price, null: false
      t.boolean :delivery, null: true
      t.boolean :available, null: true
      t.text :seller_url, null: false
      t.text :image_url, null: true
      t.string :name, null: false
      t.string :vendor_code, null: true

      t.timestamps
    end

    add_index :products, :external_id, unique: true
  end
end
