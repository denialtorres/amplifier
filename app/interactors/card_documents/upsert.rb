module CardDocuments
  class Upsert
    include Interactor

    def call
      context.card_document = upsert_documents
    rescue StandardError => e
      context.fail!(message: e.message, error_code: :internal)
    end

    private

    delegate :card_document, :client, :content, to: :context

    def upsert_documents
      client.upsert_documents(documents_params)
    end

    def documents_params
      {
        "documents": [
          {
            "id": "#{card_document.document_unique_id}",
            "text": card_document.text_document
          }
        ]
      }
    end
  end
end
