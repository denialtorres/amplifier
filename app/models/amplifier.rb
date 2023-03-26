# == Schema Information
#
# Table name: amplifiers
#
#  id                :bigint           not null, primary key
#  client_id         :integer
#  title             :string
#  start_at          :datetime
#  state             :enum
#  user_id           :bigint
#  description       :text
#  amplifier_type_id :bigint
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class Amplifier < ApplicationRecord
  belongs_to :user
  belongs_to :amplifier_type
  has_many :amplifier_conversations

  # Add any validations and associations here
end
