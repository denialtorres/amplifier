FactoryBot.define do
  factory :amplifier do
    client_id { Faker::Number.number(digits: 6) }
    title { Faker::Lorem.sentence }
    start_at { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    state { "draft" }
    user
    description { Faker::Lorem.paragraph }
    amplifier_type

    factory :published_amplifier do
      state { "published" }
    end

    factory :archived_amplifier do
      state { "archived" }
    end
  end
end
