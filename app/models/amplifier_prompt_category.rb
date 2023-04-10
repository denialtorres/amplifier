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
class AmplifierPromptCategory < ApplicationRecord
  belongs_to :amplifier_prompt
  belongs_to :amplifier_type

  # Add any validations and associations here
end
