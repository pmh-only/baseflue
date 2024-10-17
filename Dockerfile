FROM public.ecr.aws/aws-observability/aws-for-fluent-bit:latest

ADD entry_edit.sh /entry_edit.sh

RUN yum install -y jq
RUN sed -i '1s;^;source /entry_edit.sh\n;' /entrypoint.sh
