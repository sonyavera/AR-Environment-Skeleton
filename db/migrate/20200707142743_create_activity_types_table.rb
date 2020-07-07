class CreateActivityTypesTable < ActiveRecord::Migration[6.0]
  def change
    create_table :activity_type do |t|
      t.string :name
      t.integer :risk_score
    end
  end
end
