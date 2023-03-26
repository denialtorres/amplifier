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
require 'rails_helper'

RSpec.describe Amplifier, type: :model do
  let(:user) { create(:user) }
  let(:amplifier_type) { create(:amplifier_type) }
  let(:amplifier) { create(:amplifier, user: user, amplifier_type: amplifier_type) }


  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:amplifier_type) }
    it { should have_many(:amplifier_conversations) }
  end

  context "state machine" do

    it "initializes in draft state" do
      expect(amplifier).to have_attributes(state: "draft")
    end

    it "transitions from draft to published" do
      amplifier.published!
      expect(amplifier).to have_attributes(state: "published")
    end

    it "transitions from published to archived" do
      amplifier.published!
      amplifier.archived!
      expect(amplifier).to have_attributes(state: "archived")
    end

    it "transitions from draft to archived" do
      amplifier.archived!
      expect(amplifier).to have_attributes(state: "archived")
    end
  end
end
