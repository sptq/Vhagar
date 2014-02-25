class AddRoleToUsers < ActiveRecord::Migration
	def up
    	add_column :users, :user_role, :string, null: false, :default => :user
	end

	def down
		remove_column :users, :user_role, :string
	end
end
