class CardDocument < ApplicationRecord
  belongs_to :user

  # Add an attribute accessor for the PDF file
  attr_accessor :pdf_file

  # Add a callback to process the PDF file before saving the record
  before_save :convert_pdf_to_text, if: -> { pdf_file.present? }

  def convert_pdf_to_text
    converter = DocumentConverter.new(pdf_file: pdf_file)
    self.text_document = converter.to_text
  end
end
