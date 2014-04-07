class AddReservedToLecture < ActiveRecord::Migration
  def change
    	add_column :lectures, :reserved, :integer, null: false, default: 0
  end
end
