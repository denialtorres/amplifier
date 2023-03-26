class CreateAmplifierPromptCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :amplifier_prompt_categories do |t|
      t.string :title
      t.string :prompt
      t.references :amplifier_prompt, foreign_key: { to_table: :amplifier_prompts }

      t.timestamps
    end
  end
end
