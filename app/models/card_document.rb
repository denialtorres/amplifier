class CardDocument < ApplicationRecord
  belongs_to :user
  has_many :messages, dependent: :destroy

  # Add an attribute accessor for the PDF file
  attr_accessor :pdf_file

  # Add a callback to process the PDF file before saving the record
  before_save :convert_pdf_to_text, if: -> { pdf_file.present? }
  after_create :upsert_documents

  def convert_pdf_to_text
    converter = DocumentConverter.new(pdf_file: pdf_file)
    self.text_document = converter.to_text
  end

  def upsert_documents
    reload # Fetch the latest data from the database, including document_unique_id
    # move this to a worker
    CardDocuments::Upsert.call(client: DocsApi.instance, card_document: self)
  end
end
