# == Schema Information
#
# Table name: attachments
#
#  id                        :bigint           not null, primary key
#  file_type                 :string
#  url                       :string
#  amplifier_conversation_id :bigint
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#
class Attachment < ApplicationRecord
  include AASM

  belongs_to :amplifier_conversation
  has_one_attached :file

  enum state: { uploaded: 0, processed: 1, error: 2 }

  # Scope to filter attachments that have a document_id
  scope :processed_files, -> { where.not(document_id: nil) }

  after_create :set_initial_state

  aasm column: :state, enum: true do
    state :uploaded, initial: true
    state :processed
    state :error

    event :process_file do
      transitions from: :uploaded, to: :processed
    end

    event :processing_failed do
      transitions from: :uploaded, to: :error
    end
  end

  private

  def set_initial_state
    uploaded!
  end
end
