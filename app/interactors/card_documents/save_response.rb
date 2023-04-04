module CardDocuments
  class SaveResponse
    include Interactor

    def call
      context.response = build_reponse
      context.response.save!
    rescue StandardError => e
      context.fail!(message: e.message, error_code: :internal)
    end

    private

    delegate :api_response, :card_document, to: :context

    def build_reponse
      card_document.messages.build(content: api_response, speaker: :ai)
    end
  end
end
