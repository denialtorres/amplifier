class RetrieveSemanticResults
  include Interactor

  def call
    # return if attachments.blank?

    context.final_converstaion = include_semantic_results
  rescue StandardError => e
    context.fail!(message: e.message, error_code: :internal)
  end

  private

  delegate :chat_conversation, :docs_api, :message, :conversation, to: :context

  def include_semantic_results
    # loop results based of the numbers of files
    semantic_result = ""

    conversation.processed_files.each do |document|
      results = docs_api.query_documents(conversation_params(document.document_id)).body
      results_data = results["results"].first["results"]
      texts = results_data.map { |result| result["text"] }
      context_semantic = texts.join("\n\n")
      semantic_result << context_semantic
    end

    assistant_semantic_context = {
      role: "user",
      content: "Based on a semantic search, here are the top results: " + semantic_result,
    }

    chat_conversation.push(assistant_semantic_context)

    chat_conversation
  end

  def conversation_params(document_id)
    {
      "queries": [
        {
          "query": message.content,
          "hyde": true,
          "filter": {
            "document_id": document_id,
          },
        },
      ],
    }
  end
end
