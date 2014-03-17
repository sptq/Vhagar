class CreateLectures < ActiveRecord::Migration
  def change
    create_table :lectures, id: :uuid do |t|
      t.string :title
      t.text :description
      t.datetime :start_date

      t.timestamps
    end
  end
end
