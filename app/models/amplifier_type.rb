# == Schema Information
#
# Table name: amplifier_types
#
#  id         :bigint           not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class AmplifierType < ApplicationRecord
  has_many :amplifiers
  has_many :amplifier_prompts
  has_many :amplifier_prompt_categories

  # Add any validations and associations here
end
