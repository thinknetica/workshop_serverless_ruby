require 'aws-sdk-s3'

def lambda_handler(event:, context:)
  puts event

  event['Records'].each do |record|
    message = JSON.parse(record['body'])
    update_id = message.delete('update_id')

    s3.put_object(
      bucket: ENV['MESSAGES_BUCKET'],
      key: "#{update_id}.json",
      body: message.to_json
    )
  end
end

def s3
  @s3||= Aws::S3::Client.new
end
