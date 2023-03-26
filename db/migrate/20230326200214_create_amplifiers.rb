class CreateAmplifiers < ActiveRecord::Migration[7.0]
  def change
    create_table :amplifiers do |t|
      t.integer :client_id
      t.string :title
      t.datetime :start_at
      t.column :state, :amplifier_status
      t.references :user, foreign_key: true
      t.text :description
      t.references :amplifier_type, foreign_key: true

      t.timestamps
    end

    add_index :amplifiers, :client_id
  end
end
