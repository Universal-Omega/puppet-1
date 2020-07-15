class cron_puppet {
    file { 'post-hook':
        ensure  => absent,
        path    => '/etc/puppet/code/.git/hooks/post-merge',
        source  => 'puppet:///modules/cron_puppet/post-merge',
        mode    => '0755',
        owner   => root,
        group   => root,
    }
    cron { 'puppet-pull':
        ensure  => present,
        command => "cd /etc/puppet/code ; /usr/bin/git pull ; sudo /usr/bin/puppet apply /etc/puppet/code/manifests/site.pp",
        user    => root,
        minute  => '*/10',
    }
    cron { 'puppet-apply':
        ensure  => absent,
        command => "sudo /usr/bin/puppet apply /etc/puppet/code/manifests/site.pp",
        user    => root,
        minute  => '*/15',
    }
}
