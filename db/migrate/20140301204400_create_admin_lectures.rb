class CreateAdminLectures < ActiveRecord::Migration
  def change
    create_table :admin_lectures do |t|
      t.string :title
      t.text :description
      t.datetime :start_date

      t.timestamps
    end
  end
end
