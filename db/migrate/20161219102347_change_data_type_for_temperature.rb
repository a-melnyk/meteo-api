class ChangeDataTypeForTemperature < ActiveRecord::Migration[5.0]
  def change
    change_column :observations, :temperature, :float
  end
end
