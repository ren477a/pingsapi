class CreatePings < ActiveRecord::Migration[5.1]
  def change
    create_table :pings do |t|
      t.references :device, foreign_key: true
      t.timestamp :epoch_time

      t.timestamps
    end
  end
end
