'''Lambda Handler'''
from __future__ import print_function
import json

def main(event, context):
    '''main method'''
    print('Welcome to the show!!!')
    print('Received event:', json.dumps(event, indent=2))
    print('Received context:', context)

    # Be excellent to one another.....

    return {
        'statusCode': '200',
        'body': '{"py": "thon"}',
        'headers': {
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': '*'
            },
        }
