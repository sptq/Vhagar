class Addgroupfields < ActiveRecord::Migration
  def change
  	add_column :users, :haveGroup, :boolean, default: false
  	add_column :users, :groupCode, :string, default: ''
  end
end
