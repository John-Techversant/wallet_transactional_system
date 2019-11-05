class CreateWallets < ActiveRecord::Migration[6.0]
  def change
    create_table :wallets do |t|
    	t.string :account_no, null: false
    	t.integer :amount, null: false, default: 0
    	t.references :entity
      t.timestamps
    end
  end
end
