class TransactionsController < ApplicationController

	def create
    Transaction.transaction do
    	debited = Debit.withdraw(debit_params)
		  Credit.deposit(credit_params) if debited
		end
	end

	private

	def credit_params
    params.permit(:transaction_amount)
      .merge(status: 'Pending', entity_id: params[:recipient_id])
	end

	def debit_params
		params.permit(:transaction_amount)
				.merge(entity_id: current_entity.id, status: 'Pending')
	end

end
