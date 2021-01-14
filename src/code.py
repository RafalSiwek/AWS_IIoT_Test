import json
from .eventmodels import S3Model, S3ModelEventBridge

from aws_lambda_powertools.utilities.parser import event_parser
from aws_lambda_powertools.utilities.typing import LambdaContext


@event_parser(model=S3Model)
def lambda_handler(event: S3Model, context: LambdaContext) -> None:
    print("Hello Lambda")
    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!'),
        'event': event
    }