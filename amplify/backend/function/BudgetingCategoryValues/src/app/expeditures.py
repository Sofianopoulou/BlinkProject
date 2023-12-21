import boto3
from datetime import datetime, timedelta
from boto3.dynamodb.conditions import Attr
import app.constants as my_const


def _get_reponse(uid: str) -> dict:
    """Read DB."""
    user_id = uid  # The uid comes from appsync

    query_conditions = {"pk": "USER#" + user_id, "sk": "budget"}

    result = my_const.table.query(
        KeyConditionExpression="pk = :pk AND sk = :sk",
        ExpressionAttributeValues={
            ":pk": query_conditions["pk"],
            ":sk": query_conditions["sk"],
        },
    )["Items"]
    print(result)

    category_amounts = {}
    for item in result:
        week = item.get("week", 1) - 1

        budget_data = item.get("budget", {})

        for category, amounts in budget_data.items():
            if amounts:
                # Convert week to an integer
                week_int = int(week)
                # Check if week_int is within the valid range of indices
                if 0 <= week_int < len(amounts):
                    category_amounts[category] = round(amounts[week_int], 2)
                else:
                    # Handle the case where week_int is out of range
                    category_amounts[category] = None
    return category_amounts


def _sum_ammont(response: list) -> float:
    """Calculate the sum of the 'amount' values in the 'Items' dictionaries."""
    total_sum = 0  # Initialize the sum to 0
    for itm in response:
        amount = itm.get(
            "amount", None
        )  # Get the 'amount' value from the dictionary
        if amount is not None:
            total_sum += amount  # Add the 'amount' value to the running sum

    return total_sum  # Return the final sum


def compute_expeditures(category_name: str, response: list) -> float:
    sorted_items = []  # Changed 'sorted' to 'sorted_items' to avoid conflicts
    date_format = "%Y-%m-%d"  # Format of the stored date in DynamoDB
    sum_total = 0
    start_date = datetime.now() - timedelta(days=7)
    end_date = datetime.now()
    for itm in response:
        if (
            itm.get("category", None)[0].lower().replace(" ", "_")
            == category_name
        ):
            date_db = itm.get(
                "date", None
            )  # Get the 'date' value from the dictionary
            if date_db is not None:
                date_tmp = datetime.strptime(date_db, date_format)
                if start_date <= date_tmp <= end_date:
                    sorted_items.append(itm)
                    sum_total += itm.get(
                        "amount", 0
                    )  # Ensure 'amount' is properly handled

    return _sum_ammont(sorted_items)  # Use the correct function name
