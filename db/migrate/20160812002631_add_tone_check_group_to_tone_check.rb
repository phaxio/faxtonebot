class AddToneCheckGroupToToneCheck < ActiveRecord::Migration
  def change
    add_reference :tone_checks, :tone_check_group, index: true, foreign_key: true
  end
end
