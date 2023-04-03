class AddNameAndMetadataToCardDocuments < ActiveRecord::Migration[7.0]
  def change
    add_column :card_documents, :name, :string
    add_column :card_documents, :metadata, :json
  end
end
