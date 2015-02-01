class AddActionToSlider < ActiveRecord::Migration
  def change
    add_column :sliders, :action, :string
  end
end
