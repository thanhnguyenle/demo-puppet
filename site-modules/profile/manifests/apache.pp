# apache profile: site-modules/profile/manifests/apache.pp
class profile::apache {
  $port    = 80
  $docroot = '/var/www'
  include apache
  apache::vhost { 'vhost.example.com':
    port    => $port,
    docroot => $docroot,
  }
}
