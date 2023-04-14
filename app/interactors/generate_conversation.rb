class GenerateConversation
  include Interactor

  def call
    context.chat_conversation = build_full_conversation
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
      ai: "assistant",
    }

    messages.each do |message|
      role = match[message[:speaker].to_sym]

      h = {
        role: role,
        content: message[:content],
      }
      chat_messages.push(h)
    end

    chat_messages.unshift(user_instruction)

    chat_messages.unshift(system_message)

    chat_messages
  end

  def user_instruction
    {
      role: "user",
      content: "whenever i refer to a video or a document or image or any type of file, I am actually talking about the results of the semantic search",
    }
  end

  def system_message
    {
      role: "system",
      content: "Based on the semantic search or conversation history answer the question or summary the information asked by the user",
    }
  end

  def retrieve_messages
    message.amplifier_conversation.messages
  end
end
