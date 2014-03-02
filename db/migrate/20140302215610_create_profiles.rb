class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :firstName,      :null => false
      t.string :lastname,       :null => false
      t.string :job,            :default => ""
      t.string :place,          :default => ""
      t.string :phone,          :default => ""

      # Assosations
      t.belongs_to :user

      t.timestamps
    end
  end
end
