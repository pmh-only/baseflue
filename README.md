# baseflue
[The `aws-for-fluent-bit` image](https://github.com/aws/aws-for-fluent-bit) but load configuration from base64 environment variable

This image is mainly focused on ECS Fargate Tasks

## Prebuilt ECR Image
This image has been uploaded to ECR Private Registry with public access policy.

so yeah. You can use this via ECR VPC Endpoints!
```
009160052643.dkr.ecr.<region>.amazonaws.com/baseflue:latest
```

## Main Features
### Configuration Injection
> [!IMPORTANT]  
> Due to design of ECS Firelens, you need to change `firelensConfiguration` field on ECS Task Definition.
> ```json
> "firelensConfiguration": {
>   "type": "fluentbit",
>   "options": {
>     "config-file-type": "file",
>     "config-file-value": "/config.conf"
>   }
> }
> ```

This image support two configuration file injection via environment variable


You can provide base64 content of `/config.conf`/`parsers.conf` file by `CONFIG`/`PARSERS` variables:
```json
{
    "image": "009160052643.dkr.ecr.ap-northeast-2.amazonaws.com/baseflue:latest",
    "environment": [
        {
            "name": "CONFIG",
            "value": "W0lOUFVUXQ0KICAgIE5hbWUgY3B1DQogICAgVGFnICBteV9jcHUNCg0KW09VVFBVVF0NCiAgICBOYW1lICBzdGRvdXQNCiAgICBNYXRjaCAq="
        },
        {
            "name": "PARSERS",
            "value": "W1BBUlNFUl0NCiAgICBOYW1lIGFwcGxvZw0KICAgIEZvcm1hdCByZWdleA0KICAgIFJlZ2V4IF4oPzxyZW1vdGVfYWRkcj4uKikgLSBcWyg/PHRpbWU+LiopXF0gIig/PG1ldGhvZD4uKikgKD88cGF0aD4uKikgKD88cHJvdG9jb2w+LiopICg/PHN0YXR1c19jb2RlPi4qKSAoPzxyZXNwb25zZV90aW1lPi4qKSAiKD88dXNlcl9hZ2VudD4uKikiICIkDQogICAgVGltZV9LZXkgdGltZQ0KICAgIFRpbWVfRm9ybWF0ICVZLSVtLSVkVCVIOiVNOiVTJXo="
        }
    ]
}
```

### Task Metadata Injection
Like [`init` tagged image from original image](https://github.com/aws/aws-for-fluent-bit?tab=readme-ov-file#using-the-init-tag), This support Metadata Injection which crawled from [Task Metadata Endpoint Version 4](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-metadata-endpoint-v4.html)

Currently this image supports two of them
* `TASK_ARN`: ARN string of running task
* `TASK_ID`: Task id extracted from `TASK_ARN`

### PRE_EXEC
Run a bash script in same process tree before fluentbit daemon starts.
This is useful when you need to `chmod` before loading logs from another container through ECS Volumes.

Quick example:
```json
{
    "image": "009160052643.dkr.ecr.ap-northeast-2.amazonaws.com/baseflue:latest",
    "environment": [
        {
            "name": "PRE_EXEC",
            "value": "Y2htb2QgYStyd3ggL2FwcC9sb2c="
        }
    ],
    "mountPoints": [
        {
            "sourceVolume": "log",
            "containerPath": "/app/log",
            "readOnly": false
        }
    ]
}
```

## Complete Task Definition Example
```json
{
    "name": "log_router",
    "image": "009160052643.dkr.ecr.ap-northeast-2.amazonaws.com/baseflue:latest",
    "cpu": 102,
    "portMappings": [],
    "essential": true,
    "environment": [
        {
            "name": "CONFIG",
            "value": "W1NFUlZJQ0VdDQogICAgRmx1c2ggICAgICAgICAgIDUNCiAgICBEYWVtb24gICAgICAgICAgb2ZmDQogICAgTG9nX0xldmVsICAgICAgIGRlYnVnDQogICAgUGFyc2Vyc19GaWxlICAgIC9wYXJzZXJzLmNvbmYNCg0KW0lOUFVUXQ0KICAgIE5hbWUgdGFpbA0KICAgIFRhZyAgYXBwLmxvZw0KICAgIFBhdGggL2FwcC9sb2cvYXBwLmxvZw0KICAgIFBhcnNlciBhcHBsb2cNCg0KW09VVFBVVF0NCiAgICBOYW1lIGNsb3Vkd2F0Y2hfbG9ncw0KICAgIE1hdGNoICAgKg0KICAgIHJlZ2lvbiBhcC1ub3J0aGVhc3QtMg0KICAgIGxvZ19ncm91cF9uYW1lIC93c2kvd2ViYXBwL3Byb2R1Y3QNCiAgICBsb2dfc3RyZWFtX3ByZWZpeCAke1RBU0tfSUR9LQ0KICAgIGF1dG9fY3JlYXRlX2dyb3VwIE9uDQo="
        },
        {
            "name": "PRE_EXEC",
            "value": "Y2htb2QgYStyd3ggL2FwcC9sb2c="
        },
        {
            "name": "PARSERS",
            "value": "W1BBUlNFUl0NCiAgICBOYW1lIGFwcGxvZw0KICAgIEZvcm1hdCByZWdleA0KICAgIFJlZ2V4IF4oPzxyZW1vdGVfYWRkcj4uKikgLSBcWyg/PHRpbWU+LiopXF0gIig/PG1ldGhvZD4uKikgKD88cGF0aD4uKikgKD88cHJvdG9jb2w+LiopICg/PHN0YXR1c19jb2RlPi4qKSAoPzxyZXNwb25zZV90aW1lPi4qKSAiKD88dXNlcl9hZ2VudD4uKikiICIkDQogICAgVGltZV9LZXkgdGltZQ0KICAgIFRpbWVfRm9ybWF0ICVZLSVtLSVkVCVIOiVNOiVTJXo="
        }
    ],
    "mountPoints": [
        {
            "sourceVolume": "log",
            "containerPath": "/app/log",
            "readOnly": false
        }
    ],
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
            "config-file-type": "file",
            "config-file-value": "/config.conf",
            "enable-ecs-log-metadata": "true"
        }
    }
}
```

## Copyright
&copy; Minhyeok Park (<pmh_only@pmh.codes>). 2024. All rights reserved.
