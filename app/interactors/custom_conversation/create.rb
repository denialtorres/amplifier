module CustomConversation
  class Create
    include Interactor

    def call
      context.conversation = build_conversation
      context.conversation.save!
    rescue StandardError => e
      context.fail!(message: e.message, error_code: :internal)
    end

    private

    delegate :conversation_id, to: :context

    def build_conversation
      AmplifierConversation.find_by(id: conversation_id)
    end
  end
end
