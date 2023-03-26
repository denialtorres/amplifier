class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.string :content
      t.column :speaker, :speaker_type
      t.references :amplifier_conversations, foreign_key: true

      t.timestamps
    end
  end
end
