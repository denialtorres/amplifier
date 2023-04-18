class AmplifiersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_amplifier, only: [:destroy, :update, :edit]

  def index
    @amplifiers = current_user.amplifiers.order(created_at: :desc)
    @pagy, @amplifiers = pagy(@amplifiers)
  end

  def edit
    @conversation = AmplifierConversation.find_or_create_by(amplifier: @amplifier)
  end

  def new_amplifier
    @amplifier = current_user.amplifiers.create(user: current_user, title: "Untitled",
                                                amplifier_type: AmplifierType.find_by(title: "Unassigned"))
    @client = OpenAI::Client.new
    redirect_to edit_amplifier_path(@amplifier)
  end

  def update
    if @amplifier.update(amplifier_params)
      flash[:notice] = 'Amplifier successfully updated'
      respond_to do |format|
        format.html { head :no_content }
        format.turbo_stream
      end
    else
      flash.now[:alert] = 'Failed to update amplifier'
      render 'edit'
    end
  end

  def destroy
    if @amplifier.destroy
      # Fetch the item from the next page if available
      pagy, _ = pagy(current_user.amplifiers.order(created_at: :desc))
      next_item = current_user.amplifiers.order(created_at: :desc).offset(pagy.offset + pagy.items).first

      # Update the current list of amplifiers
      @pagy, @amplifiers = pagy(current_user.amplifiers.order(created_at: :desc))

      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.remove("amplifier_#{@amplifier.id}"),
            (if next_item
               turbo_stream.append("amplifiers_list", partial: "amplifier",
                                                      locals: { amplifier: next_item })
             end),
            turbo_stream.replace("pagination", partial: "pagination", locals: { pagy: @pagy }),
          ].compact
        end
        format.html { redirect_to amplifiers_path, notice: 'Amplifier successfully deleted.' }
      end
    else
      flash[:alert] = "There was an error deleting the amplifier."
      redirect_to amplifiers_path
    end
  end

  def create_conversation
    result = CreateConversationOrganizer.call(
      conversation_id: message_params[:conversation_id],
      content: message_params[:content],
      speaker: :human
    )
    if result.success?
      render turbo_stream: [
        turbo_stream.replace(
          "message_container",
          partial: "amplifier_conversations/messages",
          locals: { message: result.message, conversation: result.conversation }
        ),
        turbo_stream.replace(
          "conversation_form",
          partial: "amplifiers/form_conversation",
          locals: {
            amplifier: result.conversation.amplifier, conversation: result.conversation,
            message: "",
          }
        ),
      ]
    end
  end

  def attachments
    @attachment = Attachment.new(amplifier_conversation_id: params[:amplifier_conversation_id])
    @attachment.file.attach(params[:attachment][:file])

    if @attachment.save
      ProcessUploadedFileJob.perform_later(@attachment.id)

      render json: { success: true, attachment: { filename: @attachment.file.filename.to_s, state: @attachment.state } }, status: :created
    else
      render json: { success: false, errors: @attachment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def amplifier_params
    params.require(:amplifier).permit(:title)
  end

  def message_params
    params.require(:amplifier_conversation).permit(:content, :conversation_id)
  end

  def find_amplifier
    @amplifier = current_user.amplifiers.find(params[:id])
  end
end
