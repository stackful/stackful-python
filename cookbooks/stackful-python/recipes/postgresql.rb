settings = node["stackful-python"]
db_name = settings["db-name"]
db_user = settings["db-user"]
db_password = settings["db-password"]
admin_password = node['postgresql']['password']['postgres']

# manually install the PostgreSQL server and client
include_recipe "postgresql::ppa_pitti_postgresql"
# Set up the correct locale (Vagrant uses non-unicode en-US by default, which causes breakage)
ENV['LANGUAGE'] = ENV['LANG'] = ENV['LC_ALL'] = "en_US.UTF-8"
include_recipe "postgresql::server"

psql_user db_user do
  host "localhost"
  admin_username 'postgres'
  admin_password admin_password
  password db_password
end

psql_database db_name do
  host "localhost"
  admin_username 'postgres'
  admin_password admin_password
  owner db_user
  encoding "'UTF8'"
end

psql_permission "#{db_user}@#{db_name} => all" do
  host "localhost"
  admin_username 'postgres'
  admin_password admin_password
  username db_user
  database db_name
  permissions ['ALL']
end
