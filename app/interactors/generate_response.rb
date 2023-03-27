class GenerateResponse
  include Interactor

  def call
    context.chatgpt_response = retrieve_response
  rescue StandardError => e
    context.fail!(message: e.message, error_code: :internal)
  end

  private

  delegate :full_conversation, :client, to: :context

  def retrieve_response
    response = client.chat(
        parameters: {
            model: "gpt-3.5-turbo", # Required.
            messages: full_conversation,
            temperature: 0.7
        })

    response.dig("choices", 0, "message", "content")
  end
end
