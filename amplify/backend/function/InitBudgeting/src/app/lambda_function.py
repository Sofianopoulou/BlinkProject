import json
from app.update_limits import update_limit_category,get_budget
from app.init_schema import create_week
from app.update_amount import update_budget
def lambda_handler(event, context):
    #Check if there is zero Trans Just return no connect with bank
    user_id = event["identity"]["claims"]["sub"]  # The uid comes from appsync
    update_budget(200,user_id)
    create_week(user_id)
    update_limit_category(user_id)
    create_week(user_id)
   
