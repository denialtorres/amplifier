# frozen_string_literal: true

class AddAmplifierTypesAndCategories < ActiveRecord::Migration[7.0]
  def up
    amplifier_types = {
      mathematics: [
        ["multiplication", "I want you to act as a Math Teacher and you are going to explain and provide examples of multiplication."],
        ["division", ""],
        ["rational numbers",""],
      ],
      social_studies: [
        "economic",
        "civic",
        "historic",
        "geography"
      ],
      science: [
        "life",
        "earth",
        "space"
      ]
    }

    amplifier_types.each do |type|
      a = AmplifierType.create(title: type[0])
      type[1].each do |category|
        a.amplifier_prompt_categories
          .create(title: category)
      end
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
