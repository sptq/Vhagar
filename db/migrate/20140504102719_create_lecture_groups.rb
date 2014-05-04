class CreateLectureGroups < ActiveRecord::Migration
  def change
    create_table :lecture_groups, id: :uuid do |t|
      t.string :title
      t.text :description

      t.timestamps
    end

    add_column :lectures, :lecture_group_id, :uuid
  end
end
