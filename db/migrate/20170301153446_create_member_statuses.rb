class CreateMemberStatuses < ActiveRecord::Migration[5.0]
  def change
    create_table :member_statuses do |t|
      t.integer :member_id
      t.string :status

      t.timestamps
    end
  end
end
