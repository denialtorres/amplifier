# == Schema Information
#
# Table name: amplifier_prompt_categories
#
#  id                  :bigint           not null, primary key
#  title               :string
#  prompt              :string
#  amplifier_prompt_id :bigint
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
require 'rails_helper'

RSpec.describe AmplifierPromptCategory, type: :model do
  it { should belong_to(:amplifier_prompt) }
end
