import json
from typing import Any, Dict, List
from pydantic import BaseModel

from aws_lambda_powertools.utilities.parser import event_parser, parse, BaseModel, envelopes
from aws_lambda_powertools.utilities.typing import LambdaContext


class S3Nodel(BaseModel):
    Records : list



@event_parser(model=S3Nodel)
def lambda_handler(event: S3Nodel, context: LambdaContext) -> None:
    print("Hello Lambda")
    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!'),
        'event': event
    }