class AddActiveStatusToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :isactive, :boolean, default: false
  end
end
