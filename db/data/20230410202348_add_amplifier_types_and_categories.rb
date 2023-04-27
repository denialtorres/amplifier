# frozen_string_literal: true

class AddAmplifierTypesAndCategories < ActiveRecord::Migration[7.0]
  def up
    amplifier_types = {
      mathematics: [
        ["multiplication", "I want you to act as a Math Teacher and you are going to explain and provide examples of multiplication."],
        ["division", "I want you to act as a Math Teacher and you are going to explain and provide examples of division."],
        ["rational numbers","I want you to act as a Math Teacher and you are going to explain and provide examples of rational numbers."],
      ],
      research: [
        ["project", "You are a college %{grade} %{role} teacher. You understand that I'm still learning and need very detailed guidance. I want you to create an exciting, original project for me to implement. Make it detailed and thorough,  and with an explanation of how each step should be done. Give me an assignment of what I need to implement. I want an impressive, large-scale, expandable explanation for the following %{topic}."]
      ],
      planner: [
        ["Spreadsheet", "Make me a spreadsheet to have the %{type} post schedule for a %{period}, making %{repetition}. There are %{number_copies} copies in three %{type}, therefore I need nine copies per week. The CTA of all copies will be the same, visit the website %{website} to request services as a creator of web pages, manager of social networks and offer digital solutions for companies. The columns should be: %{columns}, copy adapted for %{network} (all copies must be %{emotion} tone, and the appropriate hashtag for each social network). The first day is %{start_date}."]
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
