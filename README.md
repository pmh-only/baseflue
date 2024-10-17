# baseflue
aws-for-fluent-bit image but load configuration from base64 environment

this image is for ECS Fargate Tasks
```json
{
  "name": "log_router",
  "image": "009160052643.dkr.ecr.ap-northeast-2.amazonaws.com/baseflue:latest",
  "cpu": 256,
  "portMappings": [],
  "essential": true,
  "environment": [
    {
      "name": "CONFIG",
      "value": "W1BBUlNFUl0NCiAgICBOYW1lIGFwcGxvZw0KICAgIEZvcm1hdCByZWdleA0KICAgIFJlZ2V4IF4oPzxyZW1vdGVfYWRkcj4uKikgLSBcWyg/PHRpbWU+LiopXF0gIig/PG1ldGhvZD4uKikgKD88cGF0aD4uKikgKD88cHJvdG9jb2w+LiopICg/PHN0YXR1c19jb2RlPi4qKSAoPzxyZXNwb25zZV90aW1lPi4qKSAiKD88dXNlcl9hZ2VudD4uKikiICIkDQogICAgVGltZV9LZXkgdGltZQ0KICAgIFRpbWVfRm9ybWF0ICVZLSVtLSVkVCVIOiVNOiVTJXoNCg0KW0lOUFVUXQ0KICAgIE5hbWUgdGFpbA0KICAgIFRhZyAgYXBwLmxvZw0KICAgIFBhdGggL2FwcC9sb2cvYXBwLmxvZw0KICAgIFBhcnNlciBhcHBsb2cNCg0KW0ZJTFRFUl0NCiAgICBOYW1lIGVjcw0KICAgIE1hdGNoICoNCiAgICBBREQgZWNzX3Rhc2tfaWQgJFRhc2tJRA0KDQpbT1VUUFVUXQ0KICAgIE5hbWUgY2xvdWR3YXRjaF9sb2dzDQogICAgTWF0Y2ggICAqDQogICAgcmVnaW9uIGFwLW5vcnRoZWFzdC0yDQogICAgbG9nX2dyb3VwX25hbWUgL3dzaS93ZWJhcHAvcHJvZHVjdA0KICAgIGxvZ19zdHJlYW1fdGVtcGxhdGUgJGVjc190YXNrX2lkLXdlYmFwcA0KICAgIGF1dG9fY3JlYXRlX2dyb3VwIE9uDQo="
    },
    {
      "name": "PARSERS",
      "value": "W1BBUlNFUl0NCiAgICBOYW1lIGFwcGxvZw0KICAgIEZvcm1hdCByZWdleA0KICAgIFJlZ2V4IF4oPzxyZW1vdGVfYWRkcj4uKikgLSBcWyg/PHRpbWU+LiopXF0gIig/PG1ldGhvZD4uKikgKD88cGF0aD4uKikgKD88cHJvdG9jb2w+LiopICg/PHN0YXR1c19jb2RlPi4qKSAoPzxyZXNwb25zZV90aW1lPi4qKSAiKD88dXNlcl9hZ2VudD4uKikiICIkDQogICAgVGltZV9LZXkgdGltZQ0KICAgIFRpbWVfRm9ybWF0ICVZLSVtLSVkVCVIOiVNOiVTJXo="
    }
  ],
  "environmentFiles": [],
  "mountPoints": [],
  "volumesFrom": [],
  "user": "0",
  "logConfiguration": {
    "logDriver": "awslogs",
    "options": {
      "awslogs-group": "/ecs/ecs-aws-firelens-sidecar-container",
      "mode": "non-blocking",
      "awslogs-create-group": "true",
      "max-buffer-size": "25m",
      "awslogs-region": "ap-northeast-2",
      "awslogs-stream-prefix": "firelens"
    },
    "secretOptions": []
  },
  "systemControls": [],
  "firelensConfiguration": {
    "type": "fluentbit",
    "options": {
      "enable-ecs-log-metadata": "true",
      "config-file-type": "file",
      "config-file-value": "/config.conf"
    }
  }
}
```
