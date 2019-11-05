class CreateEntities < ActiveRecord::Migration[6.0]
  def change
    create_table :entities do |t|
    	t.string :name
    	t.integer :entity_type, default: 0
      t.timestamps
    end
  end
end
