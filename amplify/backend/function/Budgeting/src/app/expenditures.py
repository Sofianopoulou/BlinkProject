from datetime import datetime, timedelta
import app.constants as my_const
from boto3.dynamodb.conditions import Attr

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
