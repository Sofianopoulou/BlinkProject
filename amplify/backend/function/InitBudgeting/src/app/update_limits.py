import json
import boto3
from boto3.dynamodb.conditions import Attr
from decimal import Decimal
import app.constants as my_const

_COUNT = "count"


def _get_reponse() -> list:
    """Read DB."""
    return my_const.table.scan()


def get_budget(uid:str):
    response =my_const.table.scan(
        # IndexName="GSI1",
        ProjectionExpression="sk,amount",
        FilterExpression=Attr("sk").begins_with("budget")& Attr("pk").eq("USER#"+uid),)
    return response["Items"][0]["amount"]


def _get_categories(response: list) -> list:
    """Fetch all the categories in the db ."""
    categories = [[], []]
    for itm in response["Items"]:
        category = itm.get("category", None)
        if category is not None:
            if itm["sk"].startswith("limit_"):
                categories[0].append(category[0].lower().replace(" ", "_"))
                categories[1].append(itm["amount"])

    # Combine the category names and weekly limits
    categories = list(zip(categories[0], categories[1]))

    return categories


def _get_categories_data(categories: list) -> list:
    """Initialize per category values to 0 and we define the schema ."""
    return [
        {
            "main_category": cat[0],
            "sum": 0,
            _COUNT: 0,
        }
        for cat in categories
    ]


def _modify_category(*, categories_data: list, index: int, itm: list()) -> list:
    """Update categories_data with +1+sum make the mean ."""
    idx = index
    cat_data_idx = categories_data[idx]
    cat_data_idx[_COUNT] = cat_data_idx[_COUNT] + 1
    cat_data_idx["sum"] = cat_data_idx["sum"] + abs(itm["amount"])
    return categories_data


def _get_item_category(itm: list) -> str:
    """Get the item category name if category and amount exists."""
    item_category_tmp = itm.get("category")
    amount_category_tmp = itm.get("amount")
    if item_category_tmp is not None and amount_category_tmp is not None:
        return str(item_category_tmp[0])


def _compute_category(*, categories_data: list, itm: list) -> list:
    """For each record we update the values of categories_data."""
    for n_category, category in enumerate(categories_data):
        item_category_name = _get_item_category(itm)
        if str(item_category_name).lower().replace(" ", "_") == str(
            category.get("main_category"),
        ):
            categories_data = _modify_category(
                categories_data=categories_data,
                index=n_category,
                itm=itm,
            )
    return categories_data


def update_limit_category(uid: str):
    response =  my_const.table.scan()  # We got data
    categories = _get_categories(response)  # Find all categories in the table
    categories_data = _get_categories_data(
        categories,
    )  # Create a  new list with the schema we want
    for record in response.get("Items"):
        categories_data = _compute_category(
            categories_data=categories_data,
            itm=record,
        )

    for record in categories_data:
        main_category = record["main_category"]
        record["average"] = record["sum"] / record["count"]

    # Calculate the total sum
    total_sum = sum(item["sum"] for item in categories_data)
    # Create the new dictionary with 'main_category' and 'weight'
    result_weight = []
    for item in categories_data:
        weight = item["sum"] / total_sum
        new_item = {"main_category": item["main_category"], "weight": weight}
        result_weight.append(new_item)

    if round(sum(item["weight"] for item in result_weight)) == 1:
        budget = get_budget(uid)
        for itm in result_weight:
            itm["limit"] = Decimal(budget) * Decimal(itm["weight"])

        for itm in result_weight:
            limit_tmp = itm["limit"]
            my_const.table.update_item(
                Key={
                    "pk": "USER#"+str(uid),
                    "sk": "limit_category_" + str(itm["main_category"]),
                },
                UpdateExpression="SET  amount= :amount_lmt",
                ExpressionAttributeValues={
                    ":amount_lmt": limit_tmp,
                },
            )
           
        query_conditions = {"pk": "USER#" + uid, "sk": "budget"}

        result =my_const.table.query( 
            KeyConditionExpression="pk = :pk AND sk = :sk",
            ExpressionAttributeValues={
                ":pk": query_conditions["pk"],
                ":sk": query_conditions["sk"],
            },
        )["Items"][0]
        budget_tmp=result["budget"]
        week=result["week"]
        return "Limits update Successfully"
    else:
        return "Weight Wrong Calculation (Not equal to 1 in total)"
