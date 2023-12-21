import json
from app.budgeting import BlinkBudgeting,get_all_uid,all_transactions
from app.expenditures import compute_expeditures
def lambda_handler(event, context):
    try:
        # Execute BlinkBudgeting function
        uids = get_all_uid()
        for uid in uids:
            responseall = all_transactions(uid)  # Got Transact
            BlinkBudgeting(
                uid=uid,
                food_and_drink_expenditure=compute_expeditures("food_and_drink",responseall
                ),
                payment_expenditure=compute_expeditures("payment",responseall),
                recreation_expenditure=compute_expeditures("recreation",responseall),
                shops_expenditure=compute_expeditures("shops",responseall),
                transfer_expenditure=compute_expeditures("transfer",responseall),
                travel_expenditure=compute_expeditures("travel",responseall)
            )

    except Exception as e:
        # Catch any exceptions and return an error message
        error_message = str(e)
        response = {
            "statusCode": 500,
            "custom_message": "Unknown Testmethod",
            "body": json.dumps({"message": "An error occurred: " + error_message}),
        }
        return response
