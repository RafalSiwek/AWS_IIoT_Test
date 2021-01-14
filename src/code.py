import json
from .eventmodels import S3Model, S3ModelEventBridge

from aws_lambda_powertools.utilities.parser import parse, event_parser, ValidationError
from aws_lambda_powertools.utilities.typing import LambdaContext


#@event_parser(model=S3Model)
#print(ValidationError)
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