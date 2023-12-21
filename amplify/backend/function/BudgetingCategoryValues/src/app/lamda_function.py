import json
import boto3
import os
import app.constants as my_const
from app.expeditures import compute_expeditures, _get_reponse
from boto3.dynamodb.conditions import Attr


def all_transactions(uid: str):
    """Read all the Transcation from all the banks ."""

    item_id = my_const.table.scan(
        ProjectionExpression="item_id",
        FilterExpression=Attr("pk").begins_with(
            "USER#" + uid + "#INSTITUTIONS"
        ),
    )
    result = []
    item_id = item_id.get("Items", [])
    for bank_id in item_id:
        query_conditions = {
            "gsi1pk": "USER#"
            + uid
            + "#ITEM#"
            + bank_id.get("item_id", "")
            + "#TRANSACTIONS"
        }
        # Append the results to 'result' instead of creating a new list
        result += my_const.table.query(
            IndexName="GSI1",
            KeyConditionExpression="gsi1pk = :pk",
            ExpressionAttributeValues={":pk": query_conditions["gsi1pk"]},
        )["Items"]

    return result


def lambda_handler(event, context):
    user_id = event["identity"]["claims"]["sub"]  # The uid comes from appsync
    response = _get_reponse(user_id)  # Got Categories Limits
    responseall = all_transactions(user_id)  # Got Transact
    table = [
        {
            "main_category": item,
            "weekly_limit": response[item],
            "weekly_expenditure": compute_expeditures(item, responseall),
        }
        for item in response
    ]

    return table
