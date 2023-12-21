from decimal import Decimal
import boto3
from boto3.dynamodb.conditions import Attr
import math
import json
import app.constants as my_const



def update_week(uid: str()):
    my_key = {
        "pk": "USER#" + str(uid),
        "sk": "budget",
    }

    week_tmp = my_const.table.get_item(
        Key=my_key,
        ProjectionExpression="week",
    )[
        "Item"
    ]["week"]
    my_const.table.update_item(
        Key=my_key,
        UpdateExpression="SET week = :week_tmp",
        ExpressionAttributeValues={":week_tmp": week_tmp + 1},
    )




def calculate_percentage(budget: float(), expenditure: float()):
    return (float(expenditure) / float(budget)) * 100


def get_category(uid: str):
    response = my_const.table.scan(
        # IndexName="GSI1",
        ProjectionExpression="category,amount",
        FilterExpression=Attr("sk").begins_with("limit_")
        & Attr("pk").eq("USER#"+uid),
    )
    return response["Items"]




def BlinkBudgeting(
    uid: str(),
    food_and_drink_expenditure: float(),
    payment_expenditure: float(),
    recreation_expenditure: float(),
    shops_expenditure: float(),
    transfer_expenditure: float(),
    travel_expenditure: float(),
):
    try:
        my_key = {
            "pk": "USER#" + str(uid),
            "sk": "budget",
        }

        item = my_const.table.get_item(
            Key=my_key,
            ProjectionExpression="week,budget",
        )["Item"]
        week_number = int(item["week"])
        budgeting = item["budget"]

        for bgt in budgeting:
            # Maping
            if bgt == "food_and_drink":
                expenditure = food_and_drink_expenditure
            elif bgt == "payment":
                expenditure = payment_expenditure
            elif bgt == "recreation":
                expenditure = recreation_expenditure
            elif bgt == "transfer":
                expenditure = transfer_expenditure
            elif bgt == "shops":
                expenditure = shops_expenditure
            elif bgt == "travel":
                expenditure = travel_expenditure

            # Calculate percentage
            percentage = calculate_percentage(
                (budgeting[bgt][week_number - 1]), expenditure
            )

            if percentage <= 50:
                split_in = 2
                adjustment = (
                    Decimal(
                        (float((budgeting[bgt][week_number - 1])) - float(expenditure))
                        * 0.7
                    )
                    / split_in
                )
                try:
                    for x in range(split_in):
                        budgeting[bgt][week_number + x] = (
                            budgeting[bgt][week_number + x] + adjustment
                        )
                except IndexError:
                    # Exception happens when the list has in memory
                    # (Numbers is random)
                    # data for the next 2 weeks but this percentage should modify the next 5
                    limit_category = get_category(uid)
                    for lmt in limit_category:
                        if lmt["category"][0] == bgt:
                            for x in range(
                                (len(budgeting[bgt]) - week_number + split_in)
                            ):
                                budgeting[bgt].append(lmt["amount"] + adjustment)
                # print(budgeting[bgt])
            elif percentage <= 80:
                split_in = 2
                adjustment = (
                    Decimal(
                        (float((budgeting[bgt][week_number - 1])) - float(expenditure))
                        * 0.5
                    )
                    / split_in
                )
                try:
                    for x in range(split_in):
                        budgeting[bgt][week_number + x] = (
                            budgeting[bgt][week_number + x] + adjustment
                        )
                except IndexError:
                    limit_category = get_category(uid)
                    for lmt in limit_category:
                        if lmt["category"][0] == bgt:
                            for x in range(
                                (len(budgeting[bgt]) - week_number + split_in)
                            ):
                                budgeting[bgt].append(lmt["amount"] + adjustment)
                    # print(budgeting[bgt])
            elif percentage <= 100:
                split_in = 1
                adjustment = (
                    Decimal(
                        (float((budgeting[bgt][week_number - 1])) - float(expenditure))
                        * 0.5
                    )
                    / split_in
                )
                try:
                    budgeting[bgt][week_number] = (
                        budgeting[bgt][week_number] + adjustment
                    )

                except IndexError:
                    limit_category = get_category(uid)
                    for lmt in limit_category:
                        if lmt["category"][0] == bgt:
                            for x in range(
                                (len(budgeting[bgt]) - week_number + split_in)
                            ):
                                budgeting[bgt].append(lmt["amount"] + adjustment)
                    # print(budgeting[bgt])
            elif percentage <= 120:
                split_in = 4
                adjustment = (
                    Decimal(
                        (float((budgeting[bgt][week_number - 1])) - float(expenditure))
                    )
                    / split_in
                )
                try:
                    for x in range(split_in):
                        budgeting[bgt][week_number + x] = (
                            budgeting[bgt][week_number + x] + adjustment
                        )

                except IndexError:
                    limit_category = get_category(uid)
                    for lmt in limit_category:
                        if lmt["category"][0] == bgt:
                            for x in range(
                                (len(budgeting[bgt]) - week_number + split_in)
                            ):
                                budgeting[bgt].append(lmt["amount"] + adjustment)
                # print(budgeting[bgt])
            elif percentage <= 150:
                split_in = 4
                adjustment = (
                    Decimal(
                        (float((budgeting[bgt][week_number - 1])) - float(expenditure))
                    )
                    / split_in
                )
                try:
                    for x in range(split_in):
                        budgeting[bgt][week_number + x] = (
                            budgeting[bgt][week_number + x] + adjustment
                        )

                except IndexError:
                    limit_category = get_category(uid)
                    for lmt in limit_category:
                        if lmt["category"][0] == bgt:
                            for x in range((week_number + split_in)):
                                budgeting[bgt].append(lmt["amount"] + adjustment)
                # print(budgeting[bgt])
            elif percentage > 150:
                split_in = math.floor(((percentage - 150) / 12.5) + 4)
                adjustment = (
                    Decimal(
                        (float((budgeting[bgt][week_number - 1])) - float(expenditure))
                    )
                    / split_in
                )
                limit_category = get_category(uid)

                for i in range(split_in):
                    try:
                        budgeting[bgt][week_number + i] += adjustment
                    except IndexError:
                        for lmt in limit_category:
                            if lmt["category"][0] == bgt:
                                budgeting[bgt].append(lmt["amount"] + adjustment)

        update_week(uid=uid)
        my_const.table.update_item(
            Key=my_key,
            UpdateExpression="SET budget = :budget_tmp",
            ExpressionAttributeValues={":budget_tmp": budgeting},
        )
        for category in budgeting:
            curent_limit = budgeting[category][week_number]

            my_const.table.update_item(
                Key={
                    "pk": "USER#" + str(uid),
                    "sk": "limit_category_" + str(category),
                },
                UpdateExpression="SET amount = :amount_tmp, category = :catgory_tmp",
                ExpressionAttributeValues={
                    ":amount_tmp": curent_limit,
                    ":catgory_tmp": [str(category)],
                },
            )

        print("This uid " + uid + " is  OKEY")

    except Exception:
        print("This uid " + uid + " is  no connect with any bank")
        return "False"


def get_all_uid():#User_id
    all_uids = []
    response = my_const.USERS

    # Add the users from the current page to the list
    for user in response["Users"]:
        all_uids.append(user["Username"])

    # Check if there are more pages of users
    while "PaginationToken" in response:
        pagination_token = response["PaginationToken"]
        response = client.list_users(
            UserPoolId=user_pool_id, PaginationToken=pagination_token
        )
        for user in response["Users"]:
            all_uids.append(user["Username"])

    return all_uids


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

