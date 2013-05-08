name 'python-webserver'
description 'Stackful.io Python web app server'

default_attributes({
  "nginx" => {
    "install_method" => "package",
    "init_style" => "init",
    "version" => "1.3.14"
  },
})

# PostgreSQL package names need to be overridden
override_attributes({
  "postgresql" => {
    "enable_pitti_ppa" => true,
    "listen_address" => "localhost",
    "version" => "9.2",
    "server" => {
      "packages" => ["postgresql-9.2"]
    },
    "client" => {
      "packages" => ["postgresql-client-9.2", "libpq-dev"]
    },
    "config" => {
      "ssl" => false
    }
  }
})


run_list [
  "recipe[python::default]",
#postgresql db creation fails on Vagrant boxes if the locale isn't set to en_US.UTF-8
  "recipe[set_locale::default]",
  "recipe[postgresql::ppa_pitti_postgresql]",
  "recipe[postgresql::server]",
  "recipe[stackful-python::postgresql]",
]
