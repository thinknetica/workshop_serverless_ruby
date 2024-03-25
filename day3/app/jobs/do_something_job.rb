class DoSomethingJob < ApplicationJob
  def perform(user:)
    Rails.logger.info "Doing something"
    Rails.logger.info "User: #{user}"
  end
end
