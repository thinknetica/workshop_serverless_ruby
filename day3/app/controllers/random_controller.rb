class RandomController < ActionController::API
  def yo
    DoSomethingJob.perform_later(user: "lamby")
    render json: { hi: 'yo', queue_name: ENV['JOBS_QUEUE_NAME'], queue_url: ENV['JOBS_QUEUE_URL'], region: ENV['AWS_REGION'] }
  end
end
