require 'aws-sdk-dynamodb'

def lambda_handler(event:, context:)
  body = JSON.parse(event['body'])
  message = body['message']
  puts message

  result = {
    date: message['date'],
    message: message['text'],
    name: message['from']['first_name'],
    id: body['update_id']
  }

  puts result

  resp = dynamodb.put_item(
    table_name: ENV['DYNAMODB_TABLE'],
    item: result,
    return_consumed_capacity: 'TOTAL'
  )

  puts resp
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

def dynamodb
  @dynamodb ||= Aws::DynamoDB::Client.new
end
