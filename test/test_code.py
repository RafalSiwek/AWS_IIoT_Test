import pytest
import src.code as lambdaCode
import events_test_code as events
# event1 = {
#   "Records": [
#     {
#       "eventVersion": "2.1",
#       "eventSource": "aws:s3",
#       "awsRegion": "us-east-2",
#       "eventTime": "2019-09-03T19:37:27.192Z",
#       "eventName": "ObjectCreated:Put",
#       "userIdentity": {
#         "principalId": "AWS:AIDAINPONIXQXHT3IKHL2"
#       },
#       "requestParameters": {
#         "sourceIPAddress": "205.255.255.255"
#       },
#       "responseElements": {
#         "x-amz-request-id": "D82B88E5F771F645",
#         "x-amz-id-2": "vlR7PnpV2Ce81l0PRw6jlUpck7Jo5ZsQjryTjKlc5aLWGVHPZLj5NeC6qMa0emYBDXOo6QBU0Wo="
#       },
#       "s3": {
#         "s3SchemaVersion": "1.0",
#         "configurationId": "828aa6fc-f7b5-4305-8584-487c791949c1",
#         "bucket": {
#           "name": "lambda-artifacts-deafc19498e3f2df",
#           "ownerIdentity": {
#             "principalId": "A3I5XTEXAMAI3E"
#           },
#           "arn": "arn:aws:s3:::lambda-artifacts-deafc19498e3f2df"
#         },
#         "object": {
#           "key": "b21b84d653bb07b05b1e6b33684dc11b",
#           "size": 1305107,
#           "eTag": "b21b84d653bb07b05b1e6b33684dc11b",
#           "sequencer": "0C0F6F405D6ED209E1"
#         }
#       }
#     }
#   ]
# }

# event2= 100
# event3={'body': json.dumps('Hello from Lambda!')}

@pytest.mark.parametrize("input,expected",[(events.s3EventPass,200),(events.s3EventIntGarbage,400),(events.s3EventObjGarbage,400)])
def test_lambda_handler_invoke(input,expected):
    
  lInvoke = lambdaCode.lambda_handler(input,None)
  lInvoke_Status = lInvoke['statusCode']
  print(lInvoke)
  assert lInvoke_Status == expected

#test_lambda_handler_invoke(events.s3EventObjGarbage,200)