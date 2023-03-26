class CreateCustomTypes < ActiveRecord::Migration[7.0]
  def up
    execute <<-SQL
      CREATE TYPE amplifier_status AS ENUM (
        'draft',
        'published',
        'archived'
      );

      CREATE TYPE conversation_type AS ENUM (
        'question',
        'answer'
      );

      CREATE TYPE speaker_type AS ENUM (
        'ai',
        'human'
      );
    SQL
  end

  def down
    execute <<-SQL
      DROP TYPE amplifier_status;
      DROP TYPE conversation_type;
      DROP TYPE speaker_type;
    SQL
  end
end
