FROM amazon/aws-for-fluent-bit

RUN sed -i '1s;^;cat /fluent-bit/etc/fluent-bit.conf\n;' /entrypoint.sh
RUN sed -i '1s;^;base64 -d <<< $CONFIG > /fluent-bit/etc/fluent-bit.conf\n;' /entrypoint.sh
