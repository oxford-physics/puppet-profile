class profile::pp_torque_server::default () {

#Class [ 'torque::server' ] -> Class [ 'torque::params' ] 
class {'torque::server' : }
notify { "In torque server" :} 
}

      
