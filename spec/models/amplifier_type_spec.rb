# == Schema Information
#
# Table name: amplifier_types
#
#  id         :bigint           not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe AmplifierType, type: :model do
  it { should have_many(:amplifiers) }
  it { should have_many(:amplifier_prompts) }
end
