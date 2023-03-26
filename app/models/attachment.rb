# == Schema Information
#
# Table name: attachments
#
#  id                         :bigint           not null, primary key
#  file_type                  :string
#  url                        :string
#  amplifier_conversations_id :bigint
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#
class Attachment < ApplicationRecord
  belongs_to :amplifier_conversation

  # Add any validations and associations here
end
