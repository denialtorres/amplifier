class CreateCardDocuments < ActiveRecord::Migration[7.0]
  def change
    create_table :card_documents do |t|
      t.uuid :document_unique_id, default: "gen_random_uuid()", null: false
      t.text :text_document
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
    add_index :card_documents, :document_unique_id, unique: true
  end
end
