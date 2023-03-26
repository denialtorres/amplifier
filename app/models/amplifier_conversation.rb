# == Schema Information
#
# Table name: amplifier_conversations
#
#  id                :bigint           not null, primary key
#  content           :text
#  amplifier_id      :bigint
#  conversation_type :enum
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class AmplifierConversation < ApplicationRecord
  belongs_to :amplifier
  has_many :attachments, dependent: :destroy
  has_many :messages, dependent: :destroy

  # TODO: Discuss this since a converstion is a collection of question and answers
  enum conversation_type: { question: 'question', answer: 'answer' }
end
