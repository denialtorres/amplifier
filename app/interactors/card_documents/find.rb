module CardDocuments
  class Find
    include Interactor

    def call
      context.card_document = retrieve_card_document
    rescue StandardError => e
      context.fail!(message: e.message, error_code: :internal)
    end

    private

    def retrieve_card_document
      CardDocument.find(context.card_document_id)
    end
  end
end
