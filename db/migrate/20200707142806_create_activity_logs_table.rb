class CreateActivityLogsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :activity_logs do |t|
      t.integer :user_id
      t.integer :activity_type_id
      t.date :date
    end
  end
end
