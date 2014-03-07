class RenameTableAdminLeturesToLectures < ActiveRecord::Migration
  def change
  	rename_table :admin_lectures, :lectures
  end
end
