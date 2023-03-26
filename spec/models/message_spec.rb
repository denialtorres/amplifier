require 'rails_helper'

RSpec.describe Message, type: :model do
  describe 'associations' do
    it { should belong_to(:amplifier_conversation) }
  end

  describe 'enums' do
    it { should define_enum_for(:speaker).with_values(ai: 'ai', human: 'human')
                                         .backed_by_column_of_type(:enum) }
  end

  describe 'invalid enum value' do
    it 'raises an error when an invalid value is assigned to speaker' do
      message = Message.new

      expect { message.speaker = 'invalid_value' }.to raise_error(ArgumentError)
    end
  end
end
