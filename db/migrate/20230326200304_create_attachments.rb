class CreateAttachments < ActiveRecord::Migration[7.0]
  def change
    create_table :attachments do |t|
      t.string :file_type
      t.string :url
      t.references :amplifier_conversations, foreign_key: true

      t.timestamps
    end
  end
end
