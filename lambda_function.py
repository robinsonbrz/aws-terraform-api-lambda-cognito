import json
import boto3
import os

sqs_client = boto3.client('sqs')
# queue_url = 'https://sqs.us-east-1.f.com/g/rob-sqs' # Replace with your actual SQS queue URL

queue_url = os.environ['QUEUE_URL']
print(queue_url)

import json

def lambda_function(event, context):
    message = {
        'key1': 'value1',
        'key2': 'value2'
    }

    response = sqs_client.send_message(
        QueueUrl=queue_url,
        MessageBody=json.dumps(message) # Make sure message is a string
    )

    print(response)

    return {
        'statusCode': 200,
        'body': json.dumps('Message sent to SQS!')
    }