import json
from .eventmodels import S3Model

from aws_lambda_powertools.utilities.parser import parse, event_parser, ValidationError
from aws_lambda_powertools.utilities.typing import LambdaContext


def lambda_handler(event, context: LambdaContext) -> None:
    try:
        print("Hello Lambda")
        parse(event, model=S3Model)
    except ValidationError:
        return {
            'statusCode': 400,
            'body': json.dumps('Validation error'),
            'event': event
        }
    else:
        return {
            'statusCode': 200,
            'body': json.dumps('Hello from Lambda!'),
            'event': event
        }