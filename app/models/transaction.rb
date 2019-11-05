class Transaction < ApplicationRecord
	before_save :save_transaction_id

	validates :transaction_amount, presence: true, numericality: {greater_than_or_equal_to: 1}
	validates_presence_of :entity_id

	def self.get_entity(params)
		Entity.find(params[:entity_id])
	end

	private

	def save_transaction_id
		self.transaction_id = SecureRandom.hex(8)
	end
end
