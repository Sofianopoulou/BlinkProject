import json
from app.lamda_function import lambda_handler
def handler(event, context):
    print('received event:')
    return lambda_handler(event, context)
  
    # return {
    #   'statusCode': 200,
    #   'headers': {
    #       'Access-Control-Allow-Headers': '*',
    #       'Access-Control-Allow-Origin': '*',
    #       'Access-Control-Allow-Methods': 'OPTIONS,POST,GET'
    #   },
    #   'body': json.dumps('Hello  MyHAndler!')
    # }