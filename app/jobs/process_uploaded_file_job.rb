class ProcessUploadedFileJob < ApplicationJob
  queue_as :semantic

  def perform(attachment_id)
    attachment = Attachment.find(attachment_id)
    response = upsert_file(attachment)

    update_attachment_document_id(attachment, response) if response.errors.blank?
  end

  private

  def upsert_file(attachment)
    docs_api = DocsApi.instance
    docs_api.upsert_file({metadata: {}}, attachment)
  end

  def update_attachment_document_id(attachment, response)
    document_id = response.body["ids"].first
    attachment.update(document_id: document_id)
  end
end
