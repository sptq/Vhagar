class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles, id: :uuid do |t|
      t.string :firstName,      :null => false
      t.string :lastName,       :null => false
      t.string :job,            :default => ""
      t.string :place,          :default => ""
      t.string :phone,          :default => ""
      
      # If user is a student
      t.string :album,          :default => ""
      t.string :universityCode, :default => "" #UMCS, KUL, PL, UM
      t.string :fieldOfStudy,   :default => ""

      # Assosations
      t.uuid :user_id

      t.timestamps
    end
  end
end
