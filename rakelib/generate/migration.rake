namespace :generate do
  desc "Generate database Migration"
  task :migration, [:migration_name] do |t, args|
    if args[:migration_name].nil?
      puts "Missing argumet :migration_name !!!"
      puts "Comand example: \"bin/rake 'generate:migration[migration_name]'\""
    else
      path = File.expand_path('../../db/migrations', __dir__)
      prefix = Time.now.strftime('%Y%m%d%H%M%S')
      file_name = "#{prefix}_#{args[:migration_name].to_s}.rb"

      file = File.open("#{path}/#{file_name}", 'w')
      file << "Sequel.migration do\n"
      file << "  change do\n"
      file << "  end\n"
      file << "end"
      file.close

      puts "New migration created! db/migrations/#{file_name}"
    end
  end
end