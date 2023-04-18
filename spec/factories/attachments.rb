FactoryBot.define do
  factory :attachment do
    association :amplifier_conversation
    state { 'uploaded' }
    file { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'files', 'rubytapas.mp4'), 'application/mp4') }
  end
end
