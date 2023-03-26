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
require 'rails_helper'

RSpec.describe Attachment, type: :model do
  it { should belong_to(:amplifier_conversation).required(true) }
end
