class CreateMasterAgents < ActiveRecord::Migration[5.0]
  def change
    create_table :master_agents do |t|
      t.string :name
      t.float :commission
      t.string :login

      t.timestamps
    end
  end
end
