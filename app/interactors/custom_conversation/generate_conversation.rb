module CustomConversation
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
      chat_messages = []
      chat_messages.unshift(system_message)
    end

    def custom_prompt
      custom_inputs = context.custom_inputs
      category = AmplifierPrompt.find(context.category_id)
      template_prompt = category.description
      filled_template = template_prompt.gsub(/%\{(\w+)\}/) do |match|
        key = Regexp.last_match(1)
        custom_inputs[key]
      end
    end

    def system_message
      {
        role: "system",
        content: custom_prompt
      }
    end
  end
end
