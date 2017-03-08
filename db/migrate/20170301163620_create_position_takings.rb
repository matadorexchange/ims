class CreatePositionTakings < ActiveRecord::Migration[5.0]
  def change
    create_table :position_takings do |t|
      t.integer :member_id
      t.integer :market_id
      t.integer :position

      t.timestamps
    end
  end
end
