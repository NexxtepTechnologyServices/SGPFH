class CreateSliders < ActiveRecord::Migration
  def change
    create_table :sliders do |t|
      t.string :image
      t.string :image_alt
      t.string :text1
      t.string :text2
      t.string :text3
      t.string :text4

      t.timestamps
    end
  end
end
