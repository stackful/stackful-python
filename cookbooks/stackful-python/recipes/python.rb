settings = node["stackful-python"]
user = settings["user"]
group = settings["group"]
app_name = settings["app-name"]
virtualenv_dir = settings["virtualenv-dir"]
virtualenv_container = File.dirname(virtualenv_dir)
base_requirements_file = "base_requirements.txt"
log_file = "/var/log/#{app_name}.log"
gunicorn_config = "/etc/stackful/gunicorn.conf.py"
package 'python-pip'
execute "create virtualenv container" do
  command <<-EOCOMMAND
mkdir -p '#{virtualenv_container}' && \
chown #{user}:#{group} '#{virtualenv_container}'
EOCOMMAND

  not_if { File.exists?(virtualenv_container) }
end

# M2Crypto is weird on Ubuntu. Don't install it in the venv, and
# use the distro package instead.
# Otherwise, you get errors like:
# m2crypto.so: undefined symbol: SSLv2_method
package "python-m2crypto"

python_virtualenv "#{virtualenv_dir}" do
  owner user
  group group
  options "--system-site-packages"
  action :create
end

cookbook_file base_requirements_file do
  path File.join(virtualenv_dir, base_requirements_file)
  owner user
  group group
end

execute "#{virtualenv_dir}/bin/pip install -r #{virtualenv_dir}/#{base_requirements_file}" do
  user user
  group group
end

execute "fix log permissions" do
  command <<-EOCOMMAND
touch '#{log_file}' && \
chown #{user}:#{group} #{log_file}
EOCOMMAND

  not_if { ::File.exists?(log_file) }
end

template gunicorn_config do
  source "gunicorn.conf.py.erb"
  owner user
  group "stackful"
  mode "0660"

  notifies :restart, "service[#{app_name}]"
end
