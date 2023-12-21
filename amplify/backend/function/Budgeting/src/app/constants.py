import boto3
import os
TABLE_NAME=os.getenv("TABLE_NAME")
REGION=os.getenv("REGION")
user_pool_id = os.getenv("USER_POOL_ID")
table = boto3.resource("dynamodb", region_name=REGION).Table(TABLE_NAME)
USERS = boto3.client("cognito-idp", region_name="us-east-2").list_users(UserPoolId=user_pool_id)