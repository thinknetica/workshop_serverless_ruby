require 'json'

def lambda_handler(event:, context:)
  message = JSON.parse(event['body'])['message']

  result = {
    date: message['date'],
    message: message['text'],
    name: message['from']['first_name']
  }

  puts result

  {
    statusCode: 200,
    body: {
      message: "ok",
    }
  }
end
