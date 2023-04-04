require 'pdf-reader'

class DocumentConverter
  def initialize(pdf_file:)
    @pdf_file = pdf_file
    @text_array = []
  end

  def to_text
    reader = open_file
    extract_pages(reader)
    output_to_text
  rescue PDF::Reader::MalformedPDFError
    raise "The uploaded PDF file is malformed or has an unsupported structure. Please try another file."
  end

  private

  attr_reader :pdf_file, :text_array

  def open_file
    PDF::Reader.new(pdf_file.path)
  end

  def extract_pages(reader)
    reader.pages.each do |page|
      text_array << page.text
    end
  end

  def output_to_text
    text_array.join(' ').gsub("\x00", '')
  end
end
