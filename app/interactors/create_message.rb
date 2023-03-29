class CreateMessage
  include Interactor

  def call
    context.message = build_message
    context.message.save!
  rescue StandardError => e
    context.fail!(message: e.message, error_code: :internal)
  end

  private

  delegate :conversation, :content, to: :context

  def build_message
    conversation.messages.build(content: content, speaker: :human)
  end
end
