class AmplifiersController < ApplicationController
  before_action :authenticate_user!

  def index
    @amplifiers = current_user.amplifiers.order(created_at: :desc)
    @pagy, @amplifiers = pagy(@amplifiers)
  end

  def new
    @amplifier = current_user.amplifiers.create(user: current_user, title: "Untitled",
                                                amplifier_type: AmplifierType.find_by(title: "Unassigned")
                                                )
    @conversation = AmplifierConversation.create!(amplifier: @amplifier)
    @client = OpenAI::Client.new
  end

  def create_conversation
    result = CreateConversationOrganizer.call(
      conversation_id: message_params[:conversation_id],
      content: message_params[:content],
      speaker: :human
    )
    if result.success?
      render turbo_stream: [
        turbo_stream.append(
          "message_container",
          partial: "amplifier_conversations/messages",
          locals: { message: result.message, conversation: result.conversation  }
        ),
        turbo_stream.replace(
          "conversation_form",
          partial: "amplifiers/form_conversation",
          locals: { amplifier: result.conversation.amplifier, conversation: result.conversation, message: "" }
        )
     ]
    end
  end

  private

  def message_params
    params.require(:amplifier_conversation).permit(:content, :conversation_id)
  end
end

# render turbo_stream: [
#   turbo_stream.replace(
#     :conversation_form,
#     partial: "amplifiers/form_conversation",
#     locals: { amplifier: @amplifier, conversation: @conversation }
#   ),
#   turbo_stream.append(
#     :message_container,
#     partial: "amplifier_conversations/messages",
#     locals: { message: @message }
#   )
# ]
# end
