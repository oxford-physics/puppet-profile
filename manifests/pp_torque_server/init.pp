class profile::pp_torque_server {

#Class [ 'torque::server' ] -> Class [ 'torque::params' ] 
class {'torque::server' : }
class {'torque::params':  munge_key => 'pp_local/munge.key' }      
}

      
