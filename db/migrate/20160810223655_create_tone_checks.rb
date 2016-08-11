class CreateToneChecks < ActiveRecord::Migration
  def change
    create_table :tone_checks do |t|
      t.string :number
      t.string :note
      t.string :result
      t.string :audio_url
      t.integer :status

      t.timestamps null: false
    end
  end
end
