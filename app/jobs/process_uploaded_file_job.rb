require 'securerandom'

class ProcessUploadedFileJob < ApplicationJob
  queue_as :semantic

  def perform(attachment_id)
    attachment = Attachment.find(attachment_id)

    response = upsert_file(attachment)

    if response.errors.blank?
      update_attachment_document_id(attachment, response)
    else
      puts "Errors --> #{response.errors}"
      attachment.processing_failed!
    end

    # Broadcast the updated list of attachments
    attachments = Attachment.where(amplifier_conversation_id: attachment.amplifier_conversation_id)
    Turbo::StreamsChannel.broadcast_replace_to "attachment_list",
                          target: "attachment-list",
                          partial: "amplifiers/attachment_list",
                          locals: { attachments: attachments.order(created_at: :asc) }
  end

  private

  def upsert_file(attachment)
    docs_api = DocsApi.instance
    docs_api.upsert_file({ metadata: { room_id: SecureRandom.uuid } }, attachment)
  end

  def update_attachment_document_id(attachment, response)
    document_id = response.body["ids"].first
    attachment.update(document_id: document_id)
    # Change state to 'processed'
    attachment.process_file!
  end
end
