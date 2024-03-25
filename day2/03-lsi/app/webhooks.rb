require 'aws-sdk-dynamodb'

def lambda_handler(event:, context:)
  body = JSON.parse(event['body'])

  if body.key?('message')
    process_message(body['message'])
  elsif body.key?('message_reaction')
    process_reaction(body['message_reaction'])
  end
rescue => e
  puts e

  {
    statusCode: 200,
    body: 'OK'
  }
end

def process_message(message)
  item = {
    type: 'message',
    id: message['message_id'],
    timestamp: message['date'],
    message: message['text'],
    name: message['from']['first_name']
  }

  puts JSON.pretty_generate(item)

  resp = dynamodb.put_item(
    table_name: ENV['DYNAMODB_TABLE'],
    item: item,
    return_consumed_capacity: 'INDEXES'
  )

  puts JSON.pretty_generate(resp)

  {
    statusCode: 200,
    body: {
      method: 'sendMessage',
      chat_id: message['chat']['id'],
      text: "Привет, #{message['from']['first_name']}! Твое сообщение сохранено."
    }
  }
end

def process_reaction(reaction)
  item = {
    type: 'reaction',
    id: reaction['message_id'],
    timestamp: reaction['date'],
    reaction: reaction['new_reaction'],
    name: reaction['user']['first_name']
  }

  puts item

  resp = dynamodb.put_item(
    table_name: ENV['DYNAMODB_TABLE'],
    item: item,
    return_consumed_capacity: 'INDEXES'
  )

  puts JSON.pretty_generate(resp)

  {
    statusCode: 200,
    body: 'OK'
  }
end

def dynamodb
  @dynamodb ||= Aws::DynamoDB::Client.new
end
