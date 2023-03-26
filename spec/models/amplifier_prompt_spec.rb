require 'rails_helper'

RSpec.describe AmplifierPrompt, type: :model do
  it { should belong_to(:amplifier_type) }
  it { should have_many(:amplifier_prompt_categories) }
end
