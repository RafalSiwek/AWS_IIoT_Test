import pytest
import os
import src.code as lambdaCode

event = {
  "Records": "Hi"
}

#@pytest.mark.parametrize("expected",[100,200,300,400])
def test_lambda_handler_invoke(expected=200):
    
    lInvoke = lambdaCode.lambda_handler(event,None)
    lInvoke_Status = lInvoke['statusCode']
    print(lInvoke)
    assert lInvoke_Status == expected





