from aws_lambda_powertools.utilities.parser import BaseModel
from aws_lambda_powertools.utilities.parser.models import EventBridgeModel
class S3Model(BaseModel):
    Records : list

class S3ModelEventBridge(EventBridgeModel):
    Records : list