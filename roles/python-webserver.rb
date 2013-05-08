name 'python-webserver'
description 'Stackful.io Python web app server'

default_attributes(
  "nginx" => {
    "install_method" => "package",
    "init_style" => "init",
    "version" => "1.3.14"
  },
)


run_list [
  "recipe[python::default]",
]
