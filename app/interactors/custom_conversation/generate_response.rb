module CustomConversation
  class GenerateResponse
    include Interactor

    def call
      context.chatgpt_response = retrieve_response
    rescue StandardError => e
      context.fail!(message: e.message, error_code: :internal)
    end

    private

    delegate :final_converstaion, :client, to: :context

    def retrieve_response
      response = client.chat(
        parameters: {
          model: "gpt-3.5-turbo", # Required.
          messages: final_converstaion,
          temperature: 1.0,
        }
      )

      response.dig("choices", 0, "message", "content")
    end
  end
end
