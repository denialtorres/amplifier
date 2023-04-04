class CardDocumentsController < ApplicationController
  before_action :set_card_document, only: [:show, :edit, :update, :destroy]

  def index
    @card_documents = current_user.card_documents
  end

  def show
  end

  def new
    @card_document = current_user.card_documents.build
  end

  def create
    @card_document = current_user.card_documents.build(card_document_params)

    if @card_document.save
      redirect_to @card_document, notice: 'Card document was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @card_document.update(card_document_params)
      redirect_to @card_document, notice: 'Card document was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @card_document.destroy
    redirect_to card_documents_url, notice: 'Card document was successfully destroyed.'
  end

  def create_conversation
    result = CreateCardDocumentMessageOrganizer.call(
      content: message_params[:content],
      speaker: :human,
      card_document_id: message_params[:card_document_id]
    )

    if result.success?
      render turbo_stream: [
        turbo_stream.replace(
          "message_container",
          partial: "amplifier_conversations/messages",
          locals: { message: result.message, conversation: result.card_document  }
        ),
        turbo_stream.replace(
          "conversation_form",
          partial: "card_documents/form_conversation",
          locals: { card_document: result.card_document, message: "" }
        )
     ]
    end
  end

  private
  def set_card_document
    @card_document = current_user.card_documents.find(params[:id])
  end

  def card_document_params
    params.require(:card_document).permit(:text_document, :pdf_file, :name)
  end

  def message_params
    params.require(:card_document).permit(:content, :card_document_id)
  end
end
