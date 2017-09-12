class SimpleSso::InstallGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  # desc "This generator creates an initializer file at config/initializers"
  def create_settings_file
    puts "\n"
    msg = "Default settings and configuration file at config/simple_sso_settings.yml"
    msg = "\e[1m#{msg}\e[22m" #BOLD
    say_status(:create, msg, :cyan)

    copy_file "simple_sso_settings.yml", "config/simple_sso_settings.yml"

    puts "\n"
  end

  def create_initializer
    puts "\n"
    msg = "Initializer for simple_sso file at config/initializers/simple_sso_initializers.rb"
    msg = "\e[1m#{msg}\e[22m" #BOLD
    say_status(:create, msg, :cyan)

    copy_file "initializer.rb", "config/initializers/simple_sso_initializers.rb"

    puts "\n"
    # create_file "config/initializers/initializer.rb", "# Add initialization content here"
  end

  def create_migrations
    puts "\n"
    msg = "Migration file for simple_sso at db/migrate/**_create_simple_sso_service_tickets.simple_sso.rb"
    msg = "\e[1m#{msg}\e[22m" #BOLD
    say_status(:create, msg, :cyan)

    rake "simple_sso:install:migrations"

    puts "\n"
    # create_file "config/initializers/initializer2.rb", "# Add initialization content here ----- 2"
  end

  def run_migration
    puts "\n"
    msg2 = "\e[5mType 'Y' for YES\e[25m"
    msg2 = "\e[34m#{msg2}\e[0m"
    msg = "Do you want run migration i.e.`rake db:migrate SCOPE=simple_sso` for simple_sso? #{msg2}"
    msg = "\e[1m#{msg}\e[22m" #BOLD
    say_status(:run, msg, :cyan)

    rake "db:migrate SCOPE=simple_sso"  if yes?("\t")

    puts "\n"
  end

  # def add_route
  #   puts "\n"
  #   msg = "Routes for simple_sso"
  #   msg = "\e[1m#{msg}\e[22m" #BOLD
  #   say_status(:add, msg, :cyan)

  #   route 'mount SimpleSso::Engine => "/simple_sso"'

  #   puts "\n"
  # end
end
