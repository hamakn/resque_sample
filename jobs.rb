require 'resque'
require 'json'

module Job
  @queue = :default

  def self.perform(params)
    puts "Start perform: class: #{self}, params: #{params.to_json}"
    puts "Processed a job!"
  end
end

module FailingJob
  @queue = :failing

  def self.perform(params)
    puts "Start perform: class: #{self}, params: #{params.to_json}"
    raise 'not processable!'
    puts "Processed a job!"
  end
end
