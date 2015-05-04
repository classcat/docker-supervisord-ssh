#!/bin/bash

########################################################################
# ClassCat/Supervisord-SSH Asset files
# maintainer: Masashi Okumura < masao@classcat.com >
########################################################################

### HISTORY ###
#


############
### SSHD ###
############

function change_root_password() {
  if [ -z "$password" ]; then
    echo -e "No password specified.\n"
  else
    echo -e "root:${password}" | chpasswd
    # echo -e "${password}\n${password}" | passwd root
  fi
}


##################
### SUPERVISOR ###
##################
# See http://docs.docker.com/articles/using_supervisord/

function proc_supervisor () {
# removed the followings:
#[supervisord]
#nodaemon=true

  cat > /etc/supervisor/conf.d/supervisord.conf <<EOF
[program:ssh]
command=/usr/sbin/sshd -D

[program:rsyslog]
command=/usr/sbin/rsyslogd -n -c3
EOF
}


change_root_password
proc_supervisor

exit 0


### End of Script ###
