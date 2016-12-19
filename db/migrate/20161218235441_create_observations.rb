class CreateObservations < ActiveRecord::Migration[5.0]
  def change
    create_table :observations do |t|
      t.datetime :time
      t.integer :temperature
      t.integer :pressure
      t.integer :humidity

      t.timestamps
    end
  end
end
