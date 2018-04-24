'''Lambda Handler'''
from __future__ import print_function
import json
import boto3
import os


def get_blueprint(key):
    try:
        s3 = boto3.client('s3')

        json_body = json.loads(s3.get_object(
            Bucket=os.environ['S3_BUCKET'], Key=key)['Body'].read()
        )

        return (None, json_body.get('blueprint'))

    except Exception as ex:
        return ("{0} Error: {1}".format(type(ex), ex), None)


def response_from(error, blueprint):
    '''
    >>> def v_out(results): # Extract values except the header for test
    ...     return [v for (k, v) in results.items() if k != 'headers']

    >>> v_out(response_from('booo', None))
    ['{"error": "booo"}', '400']

    >>> v_out(response_from(None, None))
    ['{"error": "blueprint is not available"}', '400']

    >>> v_out(response_from(None, {"built": True}))
    ['{"built": true}', '200']
    '''

    response = {'headers': {
        'Content-Type': 'application/json', 'Access-Control-Allow-Origin': '*'
    }}

    if error is not None or blueprint is None:
        response.update({
            'statusCode': '400',
            'body': (
                json.dumps({'error': error}) if error is not None
                else '{"error": "blueprint is not available"}'
            )
        })
    else:
        response.update({
            'statusCode': '200',
            'body': json.dumps(blueprint),
        })

    return response


def main(event, context):
    '''main method'''
    print('Welcome to the show!!!')
    print('Received event:', json.dumps(event, indent=2))
    print('Received context:', context)

    error, blueprint = get_blueprint(event.get('key_name', 'default_key_name'))

    return response_from(error, blueprint)
