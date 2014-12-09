require "sinatra"
require "redis"
require "resque"
require "./jobs"

configure do
  #redis_url = "redis://localhost:6379"
  #uri = URI.parse(redis_url)
  Resque.redis = Redis.new  #(:host => uri.host, :port => uri.port, :password => uri.password)
  Resque.redis.namespace = "resque:sample"
end

get '/' do
  @info = Resque.info
  erb :index
end

post '/' do
  Resque.enqueue(Job, params)
  redirect "/"
end

post '/failing' do
  Resque.enqueue(FailingJob, params)
  redirect "/"
end

__END__

@@ index
<html>
  <head><title>Resque Demo</title></head>
  <body>
    <p>
      There are <%= @info[:pending] %> pending and <%= @info[:processed] %> processed jobs across <%= @info[:queues] %> queues.
    </p>
    <form method="POST">
      <input type="submit" value="Create New Job"/>
    </form>

    <form action='/failing' method='POST'>
      <input type="submit" value="Create Failing New Job"/>
    </form>
  </body>
</html>
