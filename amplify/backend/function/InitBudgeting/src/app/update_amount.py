
from decimal import Decimal
import boto3
import app.constants as my_const

def update_budget(amount:Decimal,uid:str):
    response = my_const.table.update_item(
                Key={
                    'pk': "USER#"+uid,
                    'sk': 'budget'
                },
                UpdateExpression='SET #amountAttr = :amountAttr',
                ExpressionAttributeNames={
                    '#amountAttr': 'amount'
                },
                ExpressionAttributeValues={
                    ':amountAttr': amount   # Replace with your new date value
                },
            )