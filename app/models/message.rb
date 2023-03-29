# == Schema Information
#
# Table name: messages
#
#  id                        :bigint           not null, primary key
#  content                   :string
#  speaker                   :enum
#  amplifier_conversation_id :bigint
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#
class Message < ApplicationRecord
  belongs_to :amplifier_conversation

  enum speaker: { ai: 'ai', human: 'human' }
end
