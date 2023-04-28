class AddInputsToAmplifierPrompts < ActiveRecord::Migration[7.0]
  def change
    add_column :amplifier_prompts, :inputs, :jsonb, default: {}
    add_index :amplifier_prompts, :inputs, using: :gin
  end
end
