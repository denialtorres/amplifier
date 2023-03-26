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
require 'rails_helper'

RSpec.describe AmplifierConversation, type: :model do
  it { should belong_to(:amplifier) }
  it { should have_many(:messages) }
  it { should have_many(:attachments) }
end
