import json
from app.lamda_function import lambda_handler
def handler(event, context):
    return lambda_handler(event, context)
