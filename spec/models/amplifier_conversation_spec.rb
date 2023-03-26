require 'rails_helper'

RSpec.describe AmplifierConversation, type: :model do
  it { should belong_to(:amplifier) }
  it { should have_many(:messages) }
  it { should have_many(:attachments) }
end
