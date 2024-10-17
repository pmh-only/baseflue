# baseflue
aws-for-fluent-bit image but load configuration from base64 environment

```
aws ecr get-login-password --region ap-northeast-2 | \
  docker login --username AWS --password-stdin 009160052643.dkr.ecr.ap-northeast-2.amazonaws.com

docker run -ite \
  CONFIG="W0lOUFVUXQ0KICAgIE5hbWUgY3B1DQogICAgVGFnICBteV9jcHUNCg0KW09VVFBVVF0NCiAgICBOYW1lICBzdGRvdXQNCiAgICBNYXRjaCAq" \
  009160052643.dkr.ecr.ap-northeast-2.amazonaws.com/baseflue:latest
```
