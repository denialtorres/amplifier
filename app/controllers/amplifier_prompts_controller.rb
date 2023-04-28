class AmplifierPromptsController < ApplicationController
  def index
    amplifier_type_id = params[:amplifier_type_id]
    prompts = AmplifierType.find(amplifier_type_id).amplifier_prompts
    render json: prompts
  end

  def get_partial
    @amplifier = Amplifier.find(params[:amplifier_id])
    @conversation = AmplifierConversation.find_by(amplifier: @amplifier)
    @category = AmplifierPrompt.find(params[:category_type_id])

    if params[:partial_name] == "form_conversation"
      Turbo::StreamsChannel.broadcast_replace_to "partial_wrapper",
                            target: "partial-wrapper",
                            partial: "amplifiers/form_conversation",
                            locals: { amplifier: @amplifier, conversation: @conversation, message: "", user_id: current_user.id, category: @category }
    else
      Turbo::StreamsChannel.broadcast_replace_to "partial_wrapper",
                            target: "partial-wrapper",
                            partial: "amplifiers/inputs",
                            locals: { amplifier: @amplifier, conversation: @conversation, message: "", user_id: current_user.id, category: @category  }
    end
  end
end
