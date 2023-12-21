import boto3
import os
TABLE_NAME=os.getenv("TABLE_NAME")
REGION=os.getenv("REGION")
table = boto3.resource("dynamodb", region_name=REGION).Table(TABLE_NAME)
