# == Schema Information
#
# Table name: amplifier_prompts
#
#  id                :bigint           not null, primary key
#  title             :string
#  description       :text
#  amplifier_type_id :bigint
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
require 'rails_helper'

RSpec.describe AmplifierPrompt, type: :model do
  it { should belong_to(:amplifier_type) }
  it { should have_many(:amplifier_prompt_categories) }
end
