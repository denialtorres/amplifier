# frozen_string_literal: true

class CreateCardDocumentMessageOrganizer
  include Interactor::Organizer

  organize CardDocuments::Find,
           CardDocuments::CreateMessage,
           CardDocuments::GenerateResponse,
           CardDocuments::SaveResponse

  before do
    context.client = DocsApi.instance
  end
end
