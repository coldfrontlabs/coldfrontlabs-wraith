class wraith {
  include phantomjs

  if $::operatingsystem == 'Ubuntu' or $::osfamily == 'Debian' {

    #Add wraith responsive comparison tool
    ensure_packages('libicu-dev')
    ensure_packages('imagemagick')
    ensure_packages("wraith", {'ensure' => 'present', 'provider' => 'gem', require => Package['libicu-dev', 'imagemagick']})

  } elsif $::osfamily == 'RedHat' {

    case $::operatingsystemmajrelease {
      '6': {
        # Need to upgrade ruby on Centos 6
      }
      default: {
        #Add wraith responsive comparison tool
        ensure_packages('ruby-devel')
        ensure_packages('libicu-devel')
        ensure_packages('ImageMagick')
        ensure_packages("wraith", {'ensure' => 'present', 'provider' => 'gem', require => Package['libicu-devel', 'ImageMagick', 'ruby-devel']})
      }
    }
  }
}
