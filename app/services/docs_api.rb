# wrapper for llmi api

require "httparty"
# DocsApi.instance
class DocsApi
  include HTTParty

  def initialize
    @headers = {
      "Authorization" => bearer_token,
      "Content-Type" => "application/json"
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

  def bearer_token
    "Bearer #{ENV.fetch("DOCS_AUTH_TOKEN")}"
  end

  private

  attr_reader :headers, :base_uri

  def upsert(params)
    self.class.post("#{base_uri}/documents/upsert",
                    body: params.to_json,
                    multipart: true,
                    headers: headers)
  end

  def query(params)
    self.class.post("#{base_uri}/documents/query",
                    body: params.to_json,
                    multipart: true,
                    headers: headers)
  end

  def convert(response)
    OpenStruct.new(
      errors: response.success? ? {} : response.to_s,
      body: response.success? ? response.to_s : {}
    )
  end
end
