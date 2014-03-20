class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms, id: :uuid do |t|
      t.string :title
      t.text :description
      t.integer :capacity

      t.timestamps
    end

    add_column :lectures, :room_id, :uuid
  end
end
