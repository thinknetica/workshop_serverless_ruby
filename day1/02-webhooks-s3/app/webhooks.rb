require 'aws-sdk-s3'

def lambda_handler(event:, context:)
  body = JSON.parse(event['body'])
  message = body['message']

  result = {
    date: message['date'],
    message: message['text'],
    name: message['from']['first_name']
  }

  puts result

  s3.put_object(
    bucket: ENV['MESSAGES_BUCKET'],
    key: "#{body['update_id']}.json",
    body: result.to_json
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

def s3
  @s3||= Aws::S3::Client.new
end
