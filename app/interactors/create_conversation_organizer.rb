# frozen_string_literal: true

class CreateConversationOrganizer
  include Interactor::Organizer

  organize CreateConversation,
           CreateMessage,
           GenerateConversation,
           GenerateResponse,
           SaveResponse

  before do
    context.client = OpenAI::Client.new
  end
end
