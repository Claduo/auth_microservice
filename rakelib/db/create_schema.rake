namespace :db do
  desc "Create DB Schema"
  task create_schema: :db_settings do

    Sequel.connect(Settings.db.to_hash) do |db|
      db.extension :schema_dumper
      db_schema = db.dump_schema_migration

      file = File.open('db/schema.rb', 'w')
      file << db_schema
      file&.close
    end
  end
end