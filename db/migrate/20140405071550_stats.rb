class Stats < ActiveRecord::Migration
	def change
		create_table :stats, id: :uuid do |t|
			t.integer :usersUnActivated,      	:null => false
			t.integer :usersActivated,			:null => false
			t.integer :usersWithProfile,		:null => false

			t.timestamps
		end
	end
end
