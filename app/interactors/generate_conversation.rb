class GenerateConversation
  include Interactor

  def call
    context.full_conversation = build_full_conversation
  rescue StandardError => e
    context.fail!(message: e.message, error_code: :internal)
  end

  private

  delegate :message, to: :context

  def build_full_conversation
    messages = retrieve_messages

    chat_messages = []

    match =  {
      human: "user",
      ai: "assistant"
    }

    messages.each do |message|
      role = match[message[:speaker].to_sym]

      h = {
        role: role,
        content: message[:content]
      }
      chat_messages.push(h)
    end

    return chat_messages
  end

  def retrieve_messages
    message.amplifier_conversation.messages
  end
end
