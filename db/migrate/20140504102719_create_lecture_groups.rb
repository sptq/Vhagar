class CreateLectureGroups < ActiveRecord::Migration
  def change
    create_table :lecture_groups, id: :uuid do |t|
      t.string :title
      t.text :description

      t.timestamps
    end

    add_reference :lectures, :lecture_group, index: true
  end
end
