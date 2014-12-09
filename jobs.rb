require 'resque'
require 'json'

module Retryable
  def on_failure_retry(e, *args)
    puts "Performing #{self} caused an exception (#{e}). Retrying..."
    if rand < 0.5
      Resque.enqueue Job, *args
    else
      Resque.enqueue self, *args
    end
  end
end

module Job
  @queue = :default

  def self.perform(params)
    puts "Start perform: class: #{self}, params: #{params.to_json}"
    puts "Processed a job!"
  end
end

module FailingJob
  extend Retryable
  @queue = :failing

  def self.perform(params)
    puts "Start perform: class: #{self}, params: #{params.to_json}"
    raise 'not processable!'
    puts "Processed a job!"
  end
end
