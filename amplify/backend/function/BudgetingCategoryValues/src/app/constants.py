import os
import boto3

REGION = str(os.getenv("REGION"))
TABLE_NAME = str(os.getenv("TABLE_NAME"))
table = boto3.resource("dynamodb", region_name=REGION).Table(TABLE_NAME)
