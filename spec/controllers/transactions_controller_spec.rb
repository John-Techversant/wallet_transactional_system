require 'rails_helper'

RSpec.describe TransactionsController, type: :controller do
	describe 'create a transaction' do
		let!(:recipient) {FactoryBot.create(:entity)}
		let!(:entity) {FactoryBot.create(:entity, id: 2)}
		let!(:wallet) {FactoryBot.create(:wallet, entity_id: entity.id)}
		let!(:recipient_wallet) {FactoryBot.create(:wallet, entity_id: recipient.id)}

		before(:each) do
      sign_in entity
    end

	  context 'when debit amount is greater than wallet amount' do
	    it 'creates a transaction with status Failed' do
	      debit_params = { entity_id: entity.id, transaction_amount: wallet.amount + 1, status: 'Pending' }
	    	post :create, params: { recipient_id: recipient.id, transaction_amount: wallet.amount + 1 }
	    	
	    	expect(Transaction.all.map(&:type)).not_to include('Credit')
	    	expect{Debit.withdraw(debit_params)}.to change{ Transaction.all.size }.by(1)
	    	expect(Transaction.last.status).eql? 'Failed'
	    end
	  end

	  context 'when amount debited sucessfully, but failed to credit' do
	    it 'rollback debit transaction' do
	      post :create, params: { transaction_amount: 2}
	      expect(Transaction.all.size).eql? 0
	    end
	  end

	  context 'when transaction is created' do
	    it 'debits amount from sender wallet and credits to recipient wallet' do
	    	debit_params = { entity_id: entity.id, transaction_amount: 1, status: 'Pending' }
	    	credit_params = { entity_id: recipient.id, transaction_amount: 1, status: 'Pending' }
	      post :create, params: { recipient_id: recipient.id, transaction_amount: 1 }
	      
	      expect{Debit.withdraw(debit_params)}.to change{ Transaction.all.size }.by(1)
	      expect{Credit.deposit(credit_params)}.to change{ Transaction.all.size }.by(1)
	      expect(response).to have_http_status(204)
	    end
	  end
	end
end
