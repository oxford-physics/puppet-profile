class profile::pp_client::default {

include common
#mounts
class {'yumbase' :}
class { 'emiui':   }
#I hate this, lets keep it to a minimum.  The basepackage stuff is clever though and cant break anyone elses setup.#############
Class['yumbase'] -> Class['emi_repo'] -> Package <| tag != "basepackage" |>
####################################################
class { 'pp_client::mounts': name=> ['pplxfs10:/home', '/home'] }
include "ganglia"
#data
include pp_client::local_datadirs
include stdlib
#include nis::client  

#Auth
class  { 'nis::client' :

          network => "npldecs" ,
          #files is always first
          #pass extraauth 
          extraauth => "nis"
          #optionally add an extraauth2, but really, that should be done in another profile for that auth type
          #At the moment, nis would splat that config
#         #TODO- fix that so the modules only add entries, and perhaps have a nsswitch base file to copy under (some) defined circumstance(s)? 
          }


#temporarily ignored to speed up install, worked last time i tried
class { 'pp_client::usersoftware' : }
#Commented out so that I dont start trying to mount 1.8 servers with 2.1 clients.  Try again post upgrade.
class { 'lustre_client': }
#this line can go in as many times as you like
ensure_packages ( ['nfs-utils'] )
class { 'rsyslog' : }
class { 'afs::client' : }
class { 'pp_client::tunenfs' : }
include nagios::nrpe
#######CVMFS 'PROFILE'##############
#   class { 'cvmfs_old':} 
#    $concat_base_dir = "/var/concat"
   class { 'cvmfs': }
   $cvmfs_http_proxy = 'http://t2squid01.physics.ox.ac.uk:3128'
   cvmfs::mount{'lhcb.cern.ch': cvmfs_quota_limit         => 20000,
   }
   cvmfs::mount{'atlas.cern.ch': cvmfs_quota_limit      => 20000,}
#   cvmfs::mount{'atlas.cern.ch':}

#Candate for a profile
#########################

  class {'ssh::ssh_authorized_keys' : }

####################################################
     # Use the automaster.aug lens from a to be released version of augeas
     # This can be dropped once newer than 0.10.0 is everywhere I expect.
     # This may also go wrong if there is a point release of augeas.

#######################################



}
