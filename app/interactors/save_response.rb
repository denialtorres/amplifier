  class SaveResponse
    include Interactor

    def call
      context.response = build_reponse
      context.response.save!
    rescue StandardError => e
      context.fail!(message: e.message, error_code: :internal)
    end

    private

    delegate :chatgpt_response, :conversation, to: :context

    def build_reponse
      conversation.messages.build(content: chatgpt_response, speaker: :ai)
    end
  end
