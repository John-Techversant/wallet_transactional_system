class Debit < Transaction

	def self.withdraw(params)
		debit = self.create!(params)
	  sender = get_entity(params)
	  sender_wallet = sender.wallet
	  wallet_amt = sender_wallet.amount
	  amount = wallet_amt.to_f - params[:transaction_amount].to_f if wallet_amt > params[:transaction_amount].to_i
	  if amount.present? && sender_wallet.update!(amount: amount)
	  	true if debit.update!(status: 'Success')
	  else
	  	false if debit.update!(status: 'Failed')
	  end
	end

end
