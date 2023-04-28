module CustomConversation
  class RetrieveSemanticResults
    include Interactor

    def call
      if conversation.attachments.present?
        context.final_converstaion = include_semantic_results
      else
        context.final_converstaion = chat_conversation
      end
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

      semantic_search_instructions = {
          role: "system",
          content: "You're a friendly Teacher's Assistant, your main responsibility is to assist the teacher with tasks, answer questions, and summarize texts using conversation history and semantic search results. In cases where you cannot find relevant information to address a question or task, kindly inform the teacher that you were unable to find anything relevant in the provided resources and offer guidance on how to enhance their prompt for better results. Semantic search results will be presented in order of relevance and include the resource name, allowing you to connect different results from the same or separate sources.",
      }

      assistant_semantic_context = {
        role: "user",
        content: "Based on a semantic search, here are the top results: " + semantic_result,
      }

      chat_conversation.unshift(semantic_search_instructions)
      chat_conversation.unshift(assistant_semantic_context)

      chat_conversation
    end

    def conversation_params(document_id)
      {
        "queries": [
          {
            "query": chat_conversation.first[:content],
            "hyde": true,
            "filter": {
              "document_id": document_id,
            },
          },
        ],
      }
    end
  end
end
