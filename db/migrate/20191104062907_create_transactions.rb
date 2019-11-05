class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
    	t.references :entity
    	t.string :type, null: false
    	t.string :transaction_id, unique: true, null: false
    	t.integer :transaction_amount, null: false
    	t.string :status
      t.timestamps
    end
  end
end
