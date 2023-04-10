class AddReferenceToAmplifierPromptCategory < ActiveRecord::Migration[7.0]
  def change
    add_reference :amplifier_prompt_categories, :amplifier_type, null: false, foreign_key: true
  end
end
