class CreateCustomConversationJob < ApplicationJob
  queue_as :default

  def perform(conversation_id, category_id, custom_inputs, speaker)
    result = CreateCustomConversationOrganizer.call(
      conversation_id: conversation_id,
      category_id: category_id,
      custom_inputs: custom_inputs,
      speaker: speaker
    )

    if result.success?
      Turbo::StreamsChannel.broadcast_replace_to "message_container",
                            target: "message-wrapper",
                            partial: "amplifier_conversations/messages",
                            locals: { message: result.conversation.messages.last, conversation: result.conversation, custom_conversation: true }
    end
  end
end
