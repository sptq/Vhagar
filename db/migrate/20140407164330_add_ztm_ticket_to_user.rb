class AddZtmTicketToUser < ActiveRecord::Migration
    def change
    	add_column :users, :ztmTicket, :boolean, default: false 
  	end
end
