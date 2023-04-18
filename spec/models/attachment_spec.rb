# == Schema Information
#
# Table name: attachments
#
#  id                        :bigint           not null, primary key
#  file_type                 :string
#  url                       :string
#  amplifier_conversation_id :bigint
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#
require 'rails_helper'

RSpec.describe Attachment, type: :model do
  describe 'associations' do
    it { should belong_to(:amplifier_conversation) }
    it { should have_one_attached(:file) }
  end

  describe 'state machine' do
   let(:attachment) { create(:attachment) }

   it 'should have initial state uploaded' do
     expect(attachment.uploaded?).to be_truthy
   end

   it 'transitions from uploaded to processed' do
     expect { attachment.process_file! }.to change { attachment.state }.from('uploaded').to('processed')
   end

   it 'transitions from uploaded to error' do
     expect { attachment.processing_failed! }.to change { attachment.state }.from('uploaded').to('error')
   end
 end

 describe 'scopes' do
   let!(:attachment1) { create(:attachment, state: 'uploaded', document_id: nil) }
   let!(:attachment2) { create(:attachment, state: 'processed', document_id: "1") }
   let!(:attachment3) { create(:attachment, state: 'error', document_id: nil) }

   it '.processed_files' do
     expect(Attachment.processed_files).to contain_exactly(attachment2)
   end
 end
end
