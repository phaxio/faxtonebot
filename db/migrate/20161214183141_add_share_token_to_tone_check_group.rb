class AddShareTokenToToneCheckGroup < ActiveRecord::Migration
  def change
    add_column :tone_check_groups, :share_token, :string
  end
end
