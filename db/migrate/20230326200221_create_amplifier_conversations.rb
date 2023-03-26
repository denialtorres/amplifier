class CreateAmplifierConversations < ActiveRecord::Migration[7.0]
  def change
    create_table :amplifier_conversations do |t|
      t.text :content
      t.references :amplifier, foreign_key: true
      t.column :conversation_type, :conversation_type

      t.timestamps
    end
  end
end
