import boto3
from boto3.dynamodb.conditions import Attr
import app.constants as my_const

def get_category(uid:str):
    response =my_const.table.scan(
        # IndexName='GSI1',
        ProjectionExpression="category,amount",
        FilterExpression=Attr("sk").begins_with("limit_")
        & Attr("pk").eq("USER#"+uid),    )
    response_items = response["Items"]

    if len(response_items) != 6:
        category_list = [
            "food_and_drink",
            "payment",
            "recreation",
            "shops",
            "transfer",
            "travel",
        ]
        for category in category_list:
            my_const.table.update_item(
                Key={
                     "pk": "USER#"+uid,
                    "sk": "limit_category_" + str(category),
                },
                UpdateExpression="SET amount = :amount_tmp, category = :catgory_tmp",
                ExpressionAttributeValues={
                    ":amount_tmp": 1,
                    ":catgory_tmp": [str(category)],
                },
            )
            response2 =my_const.table.scan(
                # IndexName='GSI1',
                ProjectionExpression="category,amount",
                FilterExpression=Attr("sk").begins_with("limit_")& Attr("pk").eq("USER#"+uid),            )
        response_items2 = response2["Items"]
        # Create the limit fields
        return response_items2
    else:
        return response_items


def create_week(uid:str):  # Create the structure for operate budget the next 52 weeks
    categories = get_category(uid)
    budgeting = {}
    for category in categories:
        budgeting[str(category["category"][0])] = [category["amount"]]

    tmp_budget = budgeting
    my_const.table.update_item(
        Key={
            "pk": "USER#"+uid,
            "sk": "budget",
        },
        UpdateExpression="SET week = :week_tmp, budget = :budget",
        ExpressionAttributeValues={
            ":week_tmp": 1,
            ":budget": tmp_budget,
        },
    )
    
