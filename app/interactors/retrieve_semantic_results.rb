class RetrieveSemanticResults
  include Interactor

  def call
    context.final_converstaion = include_semantic_results
  rescue StandardError => e
    context.fail!(message: e.message, error_code: :internal)
  end

  private

  delegate :chat_conversation, :docs_api, :message, to: :context

  def include_semantic_results
    results = docs_api.query_documents(conversation_params).body
    results_data = results["results"].first["results"]
    texts = results_data.map { |result| result["text"] }
    context_semantic = texts.join("\n\n")
    assistant_semantic_context = {
      role: "assistant",
      content: "Based on a semantic search, here are the top results: " + context_semantic,
    }

    chat_conversation.push(assistant_semantic_context)

    chat_conversation
  end

  def conversation_params
    {
      "queries": [
        {
          "query": message.content,
          "filter": {
            "document_id": "19f38af2-c97f-408c-b2a6-4fbfec0b0af9",
          },
        },
      ],
    }
  end
end
