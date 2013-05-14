#!/bin/bash -l
function trinidad_start() {
  cd $HOME/Developer/lims-laboratory-app
echo ${rvm_path}
echo ${rvm_ruby_string}
echo ${PROJECT_JRUBY_OPTS}
echo $JRUBY_OPTS
  RAILS_ENV=next_release bundle exec trinidad -d $HOME/Developer/lims-laboratory-app --load daemon --daemonize $HOME/Developer/lims-laboratory-app/pids/trinidad_8201.pid --config $HOME/Developer/lims-laboratory-app/config/trinidad.yml
}

function trinidad_stop() {
  kill -9 `cat $HOME/Developer/lims-laboratory-app/pids/trinidad_8201.pid`
}

function trinidad_restart() {
  cd $HOME/Developer/lims-laboratory-app
  touch tmp/restart.txt
}

trinidad_${1}
