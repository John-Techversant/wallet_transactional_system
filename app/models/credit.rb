class Credit < Transaction

	def self.deposit(params)
		begin 
			credit = self.create!(params)
			recipient = get_entity(params)
		  recipient_wallet = recipient.wallet
		  amount = recipient_wallet.try(:amount).to_f + params[:transaction_amount].to_f
		  if recipient_wallet.update!(amount: amount)
		  	credit.update!(status: 'Success')
		  else
		  	credit.update!(status: 'Failed')
		  end
		rescue
			raise ActiveRecord::Rollback
		end
	end

end
