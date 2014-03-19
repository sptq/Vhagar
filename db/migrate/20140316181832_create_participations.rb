class CreateParticipations < ActiveRecord::Migration
  def change
    create_table :participations do |t|
      t.uuid :user_id
      t.uuid :lecture_id

      t.timestamps
    end
  end
end
