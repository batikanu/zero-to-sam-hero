'''Lambda Handler'''
from __future__ import print_function
import json
import boto3
import os

def get_obj_body(key):
    try:
        s3 = boto3.client('s3')

        json_body = json.loads(s3.get_object(
            Bucket=os.environ['S3_BUCKET'], Key=key)['Body'].read()
        )

        return (None, json_body.get('blueprint'))

    except Exception as ex:
        return ("{0} Error: {1}".format(type(ex), ex), None)

def generate_response(error, blueprint):
    if error is not None or blueprint is None:
        return {
            'statusCode': '400',
            'body': json.dumps({'error': error}) if error is not None else '{"error_message": "blueprint is not available"}',
            'headers': {
                'Content-Type': 'application/json',
                'Access-Control-Allow-Origin': '*'
            },
        }
    else:
        return {
            'statusCode': '200',
            'body': json.dumps(blueprint),
            'headers': {
                'Content-Type': 'application/json',
                'Access-Control-Allow-Origin': '*'
            },
        }

def main(event, context):
    '''main method'''
    print('Welcome to the show!!!')
    print('Received event:', json.dumps(event, indent=2))
    print('Received context:', context)

    error, blueprint = get_obj_body(event.get('key_name', 'default_key_name'))

    return generate_response(error, blueprint)
