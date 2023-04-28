# frozen_string_literal: true

class CreateCustomConversationOrganizer
  include Interactor::Organizer

  organize CustomConversation::Create,
           CustomConversation::GenerateConversation,
           CustomConversation::RetrieveSemanticResults,
           CustomConversation::GenerateResponse,
           CustomConversation::SaveResponse

  before do
    context.client = OpenAI::Client.new
    context.docs_api = DocsApi.instance
  end
end
