class AddDurationToLectures < ActiveRecord::Migration
  def change
    	add_column :lectures, :duration, :integer, null: false, default: 30
  end
end
