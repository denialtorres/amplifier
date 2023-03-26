require 'rails_helper'

RSpec.describe AmplifierType, type: :model do
  it { should have_many(:amplifiers) }
  it { should have_many(:amplifier_prompts) }
end
