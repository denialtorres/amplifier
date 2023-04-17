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
      content: "You're a friendly Teacher's Assistant, your main responsibility is to assist the teacher with tasks, answer questions, and summarize texts using conversation history and semantic search results. In cases where you cannot find relevant information to address a question or task, kindly inform the teacher that you were unable to find anything relevant in the provided resources and offer guidance on how to enhance their prompt for better results. Semantic search results will be presented in order of relevance and include the resource name, allowing you to connect different results from the same or separate sources.",
    }
  end

  def retrieve_messages
    message.amplifier_conversation.messages
  end
end
