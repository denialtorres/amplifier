# wrapper for llmi api

require "http"
require "mimemagic"

# DocsApi.instance
class DocsApi
  def initialize
    @headers = {
      "Authorization" => bearer_token
    }
    @base_uri = ENV.fetch("DOCS_SERVICE_URL")
  end

  def self.instance
    new # this will initialize the client
  end

  def upsert_documents(params)
    response = upsert(params)

    convert(response)
  end

  def query_documents(params)
    response = query(params)

    convert(response)
  end

  def upsert_file(params, file_path)
    response = upload_file(params, file_path)

    convert(response)
  end

  def bearer_token
    "Bearer #{ENV.fetch("DOCS_AUTH_TOKEN")}"
  end

  private

  attr_reader :headers, :base_uri

  def upsert(params)
    HTTP.headers(headers)
        .post("#{base_uri}/documents/upsert", json: params)
  end

  def query(params)
    HTTP.headers(headers)
        .post("#{base_uri}/documents/query", json: params)
  end

  def upload_file(params, file_path)
    file_contents = IO.binread(file_path)
    file_io = StringIO.new(file_contents)
    content_type = MimeMagic.by_magic(file_io).type
    filename = File.basename(file_path)

    response = HTTP.headers(headers)
                  .post("#{base_uri}/documents/upsert-file", form: {
                    file: HTTP::FormData::File.new(file_io, content_type: content_type, filename: filename),
                    metadata: params[:metadata].to_json
                  })

    response
  end

  def convert(response)
    OpenStruct.new(
      errors: response.status.success? ? {} : response.to_s,
      body: response.status.success? ? response.to_s : {}
    )
  end
end
