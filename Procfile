web: bundle exec rackup config.ru -p $PORT
worker_default: env TERM_CHILD=1 QUEUE=default COUNT=5 INTERVAL=0.1 bundle exec rake resque:work
worker_failing: env TERM_CHILD=1 QUEUE=failing COUNT=2 INTERVAL=10 bundle exec rake resque:work
