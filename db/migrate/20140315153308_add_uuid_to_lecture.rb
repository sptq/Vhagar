class AddUuidToLecture < ActiveRecord::Migration
def up
  remove_column :lectures, :id
  add_column :lectures, :uuid, :uuid
  add_index :lectures, :uuid, unique: true
  execute "ALTER TABLE lectures ADD PRIMARY KEY (uuid);"
end
def down
  emove_index :lectures, :uuid
  remove_column :lectures, :uuid
  add_column :lectures, :id, :primary_key
  execute "ALTER TABLE lectures DROP PRIMARY KEY (uuid);"
end
end
