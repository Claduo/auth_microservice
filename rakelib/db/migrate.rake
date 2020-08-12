namespace :db do
  desc 'Run database migrations'
  task :migrate, %i[version] => :db_settings do |t,args|
    Sequel.extension :migration

    Sequel.connect(Settings.db.to_hash) do |db|
      migrations = File.expand_path('../../db/migrations', __dir__)
      version = args.version.to_i if args.version
      Sequel::Migrator.run(db, migrations, target: version)
    end

    Rake::Task['db:create_schema'].execute
  end
end