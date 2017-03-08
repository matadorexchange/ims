class CreateRates < ActiveRecord::Migration[5.0]
  def change
    create_table :rates do |t|
      t.string :member_id
      t.string :integer
      t.integer :rate
      t.string :currency

      t.timestamps
    end
  end
end
