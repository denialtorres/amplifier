require "http"
require "mimemagic"

# DocsApi.instance
class DocsApi
  def initialize
    @headers = {
      "Authorization" => bearer_token,
    }
    @base_uri = ENV.fetch("DOCS_SERVICE_URL")
  end

  def self.instance
    new # this will initialize the client
  end

  def upsert_documents(params)
    response = upsert(params)
    convert_response(response)
  end

  def query_documents(params)
    response = query(params)
    convert_response(response)
  end

  def upsert_file(params, attachment)
    response = upload_file(params, attachment)
    convert_response(response)
  end

  private

  attr_reader :headers, :base_uri

  def bearer_token
    "Bearer #{ENV.fetch("DOCS_AUTH_TOKEN")}"
  end

  def upsert(params)
    post("#{base_uri}/documents/upsert", json: params)
  end

  def query(params)
    post("#{base_uri}/documents/query", json: params)
  end

  def upload_file(params, attachment)
    form_data = build_form_data(params, attachment)
    post("#{base_uri}/documents/upsert-file", form: form_data)
  end

  def post(uri, options)
    HTTP.headers(headers).post(uri, options)
  end

  def build_form_data(params, attachment)
    file_io, content_type, filename = read_file_from_active_storage(attachment)

    {
      file: HTTP::FormData::File.new(file_io, content_type: content_type, filename: filename),
      metadata: params[:metadata].to_json,
    }
  end

  def read_file(file_path)
    file_contents = IO.binread(file_path)
    file_io = StringIO.new(file_contents)
    content_type = MimeMagic.by_magic(file_io).type
    filename = File.basename(file_path)

    [file_io, content_type, filename]
  end

  def read_file_from_active_storage(attachment)
    file_blob = attachment.file.blob
    file_contents = file_blob.download
    file_io = StringIO.new(file_contents)
    content_type = MimeMagic.by_magic(file_io).type
    filename = file_blob.filename.to_s

    [file_io, content_type, filename]
  end

  def convert_response(response)
    OpenStruct.new(
      errors: response.status.success? ? {} : response.to_s,
      body: response.status.success? ? JSON.parse(response.body) : {}
    )
  end
end
