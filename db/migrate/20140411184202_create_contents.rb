class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents, id: :uuid do |t|
      t.string :title
      t.string :image_url
      t.string :place

      t.timestamps
    end
  end
end
