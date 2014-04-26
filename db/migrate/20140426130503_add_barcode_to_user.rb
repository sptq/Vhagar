class AddBarcodeToUser < ActiveRecord::Migration
	def change
		add_column :users, :barcode, :string, :default => ''
	end
end
