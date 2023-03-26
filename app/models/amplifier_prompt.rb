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
class AmplifierPrompt < ApplicationRecord
  belongs_to :amplifier_type
  has_many :amplifier_prompt_categories

  # Add any validations and associations here
end
