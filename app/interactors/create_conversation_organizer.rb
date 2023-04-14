# frozen_string_literal: true

class CreateConversationOrganizer
  include Interactor::Organizer

  organize CreateConversation,
           CreateMessage,
           GenerateConversation,
           RetrieveSemanticResults,
           GenerateResponse,
           SaveResponse

  before do
    context.client = OpenAI::Client.new
    context.docs_api = DocsApi.instance
  end
end
