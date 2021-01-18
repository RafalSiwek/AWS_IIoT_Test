import pytest
import src.code as lambdaCode
import events_test_code as events


@pytest.mark.parametrize("input,expected",[(events.s3EventPass,200),(events.s3EventIntGarbage,400),(events.s3EventObjGarbage,400)])
def test_lambda_handler_invoke(input,expected):
    
  lInvoke = lambdaCode.lambda_handler(input,None)
  lInvoke_Status = lInvoke['statusCode']
  print(lInvoke)
  assert lInvoke_Status == expected

#test_lambda_handler_invoke(events.s3EventObjGarbage,200)