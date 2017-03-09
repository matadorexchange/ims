class CreateUserSettlementSummaries < ActiveRecord::Migration[5.0]
  def change
    create_table :user_settlement_summaries do |t|
      t.integer :week_id
      t.integer :user_id
      t.integer :value

      t.timestamps
    end
  end
end
