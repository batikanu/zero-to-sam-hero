'''Lambda Handler'''
from __future__ import print_function
import json
import boto3
import os

def read(key):
    s3 = boto3.client('s3')
    obj = s3.get_object(Bucket=os.environ['S3_BUCKET'], Key=key)
    return json.loads(obj['Body'].read())


def main(event, context):
    '''main method'''
    print('Welcome to the show!!!')
    print('Received event:', json.dumps(event, indent=2))
    print('Received context:', context)

    # Be excellent to one another.....
    s3_obj_body = read(event.get('key_name', 'default_key_name'))

    return {
        'statusCode': '200',
        'body': s3_obj_body,
        'headers': {
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': '*'
            },
        }
