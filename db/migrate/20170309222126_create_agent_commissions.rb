class CreateAgentCommissions < ActiveRecord::Migration[5.0]
  def change
    create_table :agent_commissions do |t|
      t.integer :week_id
      t.integer :master_agent_id
      t.integer :coin
      t.integer :value

      t.timestamps
    end
  end
end
