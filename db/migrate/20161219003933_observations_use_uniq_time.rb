class ObservationsUseUniqTime < ActiveRecord::Migration[5.0]
  def change
    change_table :observations do |t|
      t.index :time, unique: true
    end
  end
end
