class FixAttachmentsForeignKey < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :attachments, column: :amplifier_conversations_id
    remove_index :attachments, column: :amplifier_conversations_id

    rename_column :attachments, :amplifier_conversations_id, :amplifier_conversation_id

    add_index :attachments, :amplifier_conversation_id
    add_foreign_key :attachments, :amplifier_conversations, column: :amplifier_conversation_id
  end
end
