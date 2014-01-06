## define nginx::server
define nginx::site::settings($ensure=present, $site=undef, $settings=undef) {
  include nginx::params

  if ! $site {
    fail("Nginx::Site::Settings[site]:
      parameter must be defined")
  }
  if ! $settings {
    fail("Nginx::Site::Settings[settings]:
      parameter must be defined")
  }
  if $name !~ /^[a-zA-Z][a-zA-Z0-9_-]*$/ {
    fail("Nginx::Site::Settings[${name}]:
      parameter must be alphanumeric")
  }

  file { "${nginx::params::nginx_sites_enabled}/${site}.d/${name}.conf":
    ensure  => $ensure,
    content => template('nginx/settings.erb'),
    notify  => Service['nginx'],
  }
}
