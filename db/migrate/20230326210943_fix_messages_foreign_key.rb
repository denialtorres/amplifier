class FixMessagesForeignKey < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :messages, column: :amplifier_conversations_id
    remove_index :messages, column: :amplifier_conversations_id

    rename_column :messages, :amplifier_conversations_id, :amplifier_conversation_id

    add_index :messages, :amplifier_conversation_id
    add_foreign_key :messages, :amplifier_conversations, column: :amplifier_conversation_id
  end
end
