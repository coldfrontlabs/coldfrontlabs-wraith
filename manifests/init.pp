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
        # @todo

        # 1. Install SCL for CentOS 6 to gain access to ruby193
        # @see http://wiki.centos.org/AdditionalResources/Repositories/SCL#head-9c6aea9c13b921d5258446c4c5e5886571bdb741
        ensure_packages('centos-release-SCL')

        # 2. Install ruby193, ruby193-ruby-devel and ruby193-rake
        ensure_packages(['ruby193', 'ruby193-ruby-devel', 'ruby193-rake'], {require => Package['centos-release-SCL']})

        # 3. Install wraith with "scl enable ruby193 'bash';gem install wraith"
        # @todo probably need to do this with exec

        # 4. Create an alias for the "wraith" command to run "scl enable ruby193 wraith" and pass in arguments
        # @todo figure out how to do that part...

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