require 'aws-sdk-sqs'

def lambda_handler(event:, context:)
  body = JSON.parse(event['body'])
  message = body['message']

  result = {
    date: message['date'],
    message: message['text'],
    name: message['from']['first_name'],
    update_id: body['update_id']
  }

  puts result

  sqs.send_message(
    queue_url: ENV['MESSAGES_QUEUE'],
    message_body: result.to_json
  )
rescue => e
  puts e
ensure
  {
    statusCode: 200,
    body: {
      message: "ok"
    }
  }
end

def sqs
  @sqs ||= Aws::SQS::Client.new
end
