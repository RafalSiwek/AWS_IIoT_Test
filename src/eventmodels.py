from aws_lambda_powertools.utilities.parser import BaseModel


class S3Model(BaseModel):
    Records : list

