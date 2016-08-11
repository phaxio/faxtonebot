class CreateToneCheckGroups < ActiveRecord::Migration
  def change
    create_table :tone_check_groups do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
