namespace :db do
  desc "Run database seeds"
  task :seed, [:version] => :db_settings do
    require 'sequel/extensions/seed'
    # require models
    Dir["../../app/models/**/*.rb"].each { |file| require file}


    Sequel.connect(Settings.db.url || Settings.db.to_hash) do |db|
      Sequel.extension :seed
      Sequel::Seed.setup(ENV['RACK_ENV'].to_sym)

      seeds = File.expand_path('../../db/seeds', __dir__)
      Sequel::Seeder.apply(db, seeds)
    end
  end
end