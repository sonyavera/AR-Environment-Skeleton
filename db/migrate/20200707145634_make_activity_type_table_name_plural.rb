class MakeActivityTypeTableNamePlural < ActiveRecord::Migration[6.0]
  def change
    rename_table :activity_type, :activity_types
  end
end
