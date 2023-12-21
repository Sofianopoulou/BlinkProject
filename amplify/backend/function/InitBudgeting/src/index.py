import json
from app.lambda_function import lambda_handler
def handler(event, context):
  print('received event:')
  return lambda_handler(event, context)
