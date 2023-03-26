require 'rails_helper'

RSpec.describe Attachment, type: :model do
  it { should belong_to(:amplifier_conversation).required(true) }
end
