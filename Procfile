web: bin/rails server -p $PORT -e $RAILS_ENV
resque: env TERM_CHILD=1 COUNT=2 RESQUE_TERM_TIMEOUT=7 QUEUE=* bundle exec rake resque:workers 
