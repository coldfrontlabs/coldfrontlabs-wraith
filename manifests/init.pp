class wraith {
  include phantomjs

  if $::operatingsystem == 'Ubuntu' or $::osfamily == 'Debian' {

    #Add wraith responsive comparison tool
    ensure_packages(['libicu-dev', 'imagemagick', 'zlib1g-dev'])
    ensure_packages("wraith", {'ensure' => 'present', 'provider' => 'gem', require => [Package['libicu-dev', 'imagemagick', 'zlib1g-dev'], Class['phantomjs']]})

  } elsif $::osfamily == 'RedHat' {

    case $::operatingsystemmajrelease {
      '6': {
        # Need to upgrade ruby on Centos 6
        # @todo

        # 1. Install SCL for CentOS 6 to gain access to ruby193
        # @see http://wiki.centos.org/AdditionalResources/Repositories/SCL#head-9c6aea9c13b921d5258446c4c5e5886571bdb741
        ensure_packages('centos-release-SCL')

        # 2. Install ruby193, ruby193-ruby-devel and ruby193-rake
        ensure_packages(['ruby193', 'ruby193-ruby-devel', 'zlib-devel', 'tar', 'gcc', 'patch'], {require => Package['centos-release-SCL']})

        # 3. Install wraith with "scl enable ruby193 'bash';gem install wraith"
        # @todo probably need to do this with exec
        exec {'scl-install-ruby':
          command => "scl enable ruby193 'gem install wraith'",
          path => ['/usr/bin'],
          require => [Package['ruby193', 'ruby193-ruby-devel', 'zlib-devel', 'tar', 'gcc', 'patch'], Class['phantomjs']],
        }

        # 4. Create an alias for the "wraith" command to run "scl enable ruby193 wraith" and pass in arguments
        $wraith_command = 'wraith () {
         local wraithcommand=wraith
         local wraithcommand="$wraithcommand $@";
         echo $wraithcommand;
         scl enable ruby193 "$wraithcommand";
        }'

        file {'/etc/profile.d/wraith.sh':
          ensure => 'present',
          content => $wraith_command,
          mode => 0755,
          require => Exec['scl-install-ruby'],
        }
      }
      default: {
        #Add wraith responsive comparison tool
        ensure_packages(['ruby-devel', 'libicu-devel', 'ImageMagick'])
        ensure_packages("wraith", {'ensure' => 'present', 'provider' => 'gem', require => [Package['libicu-devel', 'ImageMagick', 'ruby-devel'], Class['phantomjs']]})
      }
    }
  }
}
