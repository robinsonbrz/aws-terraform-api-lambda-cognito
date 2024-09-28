import json
import boto3
import os

sqs_client = boto3.client('sqs')

queue_url = os.environ['QUEUE_URL']

import json

def lambda_function(event, context):
    try:
        mensagem = event.get('mensagem','')
        complemento = event.get('complemento','')
        message = {
            'mensagem': f'{mensagem}',
            'complemento': f'{complemento}'
        }
        message_attributes = {
            'mensagem': {
                'DataType': 'String',
                'StringValue': f'{mensagem}'
            },
            'complemento': {
                'DataType': 'String',
                'StringValue': f'{complemento}'
            }
        }
        response = sqs_client.send_message(
            QueueUrl=queue_url,
            MessageBody=json.dumps(message),
            MessageAttributes=message_attributes
        )
        print("Verificar prints no cloudwatch")
        return {
            'statusCode': 200,
            'body': json.dumps('Message sent to SQS!')
        }
    except Exception as e:
        return {
            'statusCode': 400,
            'body': json.dumps({'error': 'Corpo da requisição inválido', 'details': str(e)})
        }