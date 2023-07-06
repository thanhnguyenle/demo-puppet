# iis profile: site-modules/profile/manifests/iis.pp
class profile::iis {
  $iis_features = ['Web-WebServer','Web-Scripting-Tools']
  $index_content = "
  <!DOCTYPE html>
  <html>
  <body>

  <h1>Ecommerce Site</h1>

  </body>
  </html>"

  iis_feature { $iis_features:
    ensure => 'present',
  }

  # Delete the default website to prevent a port binding conflict.
  iis_site { 'Default Web Site':
    ensure  => absent,
    require => Iis_feature['Web-WebServer'],
  }

  iis_site { 'ecom':
    ensure          => 'started',
    physicalpath    => 'c:\\inetpub\\ecom',
    applicationpool => 'DefaultAppPool',
    require         => [
      File['ecom'],
      Iis_site['Default Web Site']
    ],
  }

  file { 'ecom':
    ensure => 'directory',
    path   => 'c:\\inetpub\\ecom',
  }

  file { 'index':
    require => File['ecom'],
    path    => 'c:\\inetpub\\ecom\\index.html',
    content => $index_content
  }
}
