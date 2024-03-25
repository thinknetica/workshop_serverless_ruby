class ApplicationJob < ActiveJob::Base
  include Lambdakiq::Worker
  queue_as ENV['JOBS_QUEUE_NAME']
end
