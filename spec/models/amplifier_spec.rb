require 'rails_helper'

RSpec.describe Amplifier, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:amplifier_type) }
  it { should have_many(:amplifier_conversations) }
end
