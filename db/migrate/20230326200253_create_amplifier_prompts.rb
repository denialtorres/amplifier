class CreateAmplifierPrompts < ActiveRecord::Migration[7.0]
  def change
    create_table :amplifier_prompts do |t|
      t.string :title
      t.text :description
      t.references :amplifier_type, foreign_key: true

      t.timestamps
    end
  end
end
