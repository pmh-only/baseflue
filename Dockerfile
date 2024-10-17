FROM public.ecr.aws/aws-observability/aws-for-fluent-bit:latest

RUN sed -i '1s;^;cat /fluent-bit/etc/fluent-bit.conf\n;' /entrypoint.sh
RUN sed -i '1s;^;base64 -d <<< $CONFIG > /config.conf\n;' /entrypoint.sh
