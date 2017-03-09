class CreateSettlementSummaries < ActiveRecord::Migration[5.0]
  def change
    create_table :settlement_summaries do |t|
      t.integer :week_id
      t.integer :value
      t.integer :downline
      t.integer :upline
      t.integer :agent_commission
      t.integer :profit_loss

      t.timestamps
    end
  end
end
