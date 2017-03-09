class CreateSettlements < ActiveRecord::Migration[5.0]
  def change
    create_table :settlements do |t|
      t.integer :member_id
      t.string :source
      t.integer :week_id
      t.date :from_date
      t.date :end_date
      t.integer :coin
      t.integer :value

      t.timestamps
    end
  end
end
