#!/bin/sh
### BEGIN INIT INFO
# Provides: TYPE_THIS_FILE_NAME_HERE
# Required-Start: $all
# Required-Stop: $network $local_fs $syslog
# Default-Start: 2 3 4 5
# Default-Stop: 0 1 6
# Short-Description: Start the APPLICATION unicorns at boot
# Description: Enable APPLICATION at boot time.
### END INIT INFO
#
# Use this as a basis for your own Unicorn init script.
# Change settings to match your app.
# Make sure that all paths are correct.

set -u
set -e

# SETTINGS
#
# 1. If you use .rvmrc file (with "rvm use" content)
APP_NAME=your_application_name
APP_USER="your_user" # usually it is a server administrator user
ENV=production

USER_HOME="/home/$APP_USER"
APP_ROOT="$USER_HOME/www/$APP_NAME"
PID="$APP_ROOT/tmp/pids/unicorn.pid"
UNICORN_OPTS="-D -E $ENV -c $APP_ROOT/config/unicorn.rb"
SET_PATH="source /home/$APP_USER/.rvm/scripts/rvm; cd $APP_ROOT"
CMD="$SET_PATH; unicorn_rails $UNICORN_OPTS"

# 2. If you don't use .rvmrc file (with "rvm use" content) comment previous settings and use settings below instead.
#
# APP_NAME=your_application_name
# APP_GEMSET="1.9.3@$APP_NAME"
# APP_GEMSET_PATH="ruby-1.9.3-p125@$APP_NAME"
# APP_USER="unicorn"
# USER_HOME="/home/$APP_USER"
# APP_ROOT="$USER_HOME/www/$APP_NAME"
# PID="$USER_HOME/www/$APP_NAME/tmp/pids/unicorn.pid"
# ENV=production
# GEM_HOME="$USER_HOME/.rvm/gems/$APP_GEMSET_PATH"
# UNICORN_OPTS="-D -E $ENV -c $APP_ROOT/config/unicorn.rb"
# SET_PATH="source /home/$APP_USER/.rvm/scripts/rvm; cd $APP_ROOT; rvm use $APP_GEMSET --create; export GEM_HOME=$GEM_HOME"
#CMD="$SET_PATH; $GEM_HOME/bin/unicorn_rails $UNICORN_OPTS"


# end of user settings

sig () {
test -s "$PID" && kill -$1 `cat $PID`
}

case ${1-help} in
start)
sig 0 && echo >&2 "Already running" && exit 0
su - $APP_USER -c "$CMD"
;;
stop)
sig QUIT && exit 0
echo >&2 "Not running"
;;
force-stop)
sig TERM && exit 0
echo >&2 "Not running"
;;
restart)
sig QUIT && echo stopped OK
su - $APP_USER -c "$CMD" && exit 0
echo >&2 "Couldn't restart"
;;
reload)
sig USR2 && echo reloaded OK && exit 0
echo >&2 "Couldn't 'hot'-reload, try to restart instead"
;;
*)
  echo >&2 "Usage: $0 <start|stop|restart|reload|force-stop>"
  exit 1
  ;;
esac
