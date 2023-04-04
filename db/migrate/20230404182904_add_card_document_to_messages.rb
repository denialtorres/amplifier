class AddCardDocumentToMessages < ActiveRecord::Migration[7.0]
  def change
    add_reference :messages, :card_document, null: true, foreign_key: true
  end
end
