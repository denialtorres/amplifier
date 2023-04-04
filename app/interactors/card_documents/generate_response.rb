module CardDocuments
  class GenerateResponse
    include Interactor

    def call
      context.api_response = retrieve_response
    rescue StandardError => e
      context.fail!(message: e.message, error_code: :internal)
    end

    private

    delegate :card_document, :client, :content, to: :context

    def retrieve_response
      params = generate_params

      response = client.query_documents(params)

      body_hash = JSON.parse(response.body)

      body_hash["results"].first["completion"]
    end

    def generate_params
      {
        "queries": [
          {
            "messages": [
              {
                "role": "system",
                "content": "Based on the sematic search answer the question or summary the information asked by the user"
              }
            ],
            "query": "#{content}",
            "filter": {
              "document_id": "#{card_document.document_unique_id}"
            }
          }
        ]
      }
    end
  end
end
