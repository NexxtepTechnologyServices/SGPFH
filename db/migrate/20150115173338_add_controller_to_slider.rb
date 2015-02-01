class AddControllerToSlider < ActiveRecord::Migration
  def change
    add_column :sliders, :controller, :string
  end
end
