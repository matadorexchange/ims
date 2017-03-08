class AddShareHoldingToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :share_holding, :float
  end
end
