name 'python-webserver'
description 'Stackful.io Python web app server'

default_attributes({
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
  },
  "nginx" => {
    "install_method" => "package",
    "init_style" => "init",
    "version" => "1.4.1"
  },
})


run_list [
  "recipe[python::default]",
  "recipe[postgresql::ppa_pitti_postgresql]",
  "recipe[postgresql::server]",
  "recipe[stackful-python::postgresql]",
  "recipe[stackful-python::git]",
  "recipe[stackful-python::app]",
  "recipe[stackful-python::python]",
  "recipe[stackful-python::nginx]",
]
